import { readFileSync } from 'fs'
import { parse } from 'yaml'

const GITHUB_TOKEN = process.env.GITHUB_TOKEN
const MISTRAL_API_KEY = process.env.MISTRAL_API_KEY
const INTERNAL_TOKEN = process.env.INTERNAL_REPO_TOKEN
const GITHUB_REPOSITORY = process.env.GITHUB_REPOSITORY
const [owner, repo] = GITHUB_REPOSITORY.split('/')

const config = parse(readFileSync('.github/label-config.yml', 'utf8'))
// Model-swap testing: the workflow_dispatch `model` input overrides label-config.yml
const model = process.env.INPUT_MODEL || config.model

const issueNumber = process.env.INPUT_ISSUE_NUMBER
  ? parseInt(process.env.INPUT_ISSUE_NUMBER)
  : null
const issueState = process.env.INPUT_STATE || 'open'
const dryRun = process.env.INPUT_DRY_RUN === 'true'

// Categories where exactly one label applies — if the user already picked one,
// the bot must not add a competing label from the same category.
const PICK_ONE_CATEGORIES = ['type', 'priority', 'severity']
const ALL_CATEGORIES = ['type', 'priority', 'severity', 'scope', 'concern', 'platform']

const SYNC_MARKER = 'tracked internally'

function categoryLabels(category) {
  return (config.labels[category] || []).map((l) => l.name)
}

async function ghApi(path, options = {}, token = GITHUB_TOKEN) {
  const base = path.startsWith('https://') ? '' : `https://api.github.com/repos/${owner}/${repo}`
  const res = await fetch(`${base}${path}`, {
    headers: {
      Authorization: `Bearer ${token}`,
      Accept: 'application/vnd.github+json',
      'X-GitHub-Api-Version': '2022-11-28',
    },
    ...options,
  })
  if (!res.ok) {
    throw new Error(`GitHub API ${path}: ${res.status} ${await res.text()}`)
  }
  return res.json()
}

async function mistralClassify(title, body, candidates) {
  const allLabels = ALL_CATEGORIES.flatMap((c) => config.labels[c] || [])

  const labelDefs = allLabels
    .map((l) => {
      let line = `- "${l.name}": ${l.description}`
      if (l.criteria) line += ` (criteria: ${l.criteria})`
      return line
    })
    .join('\n')

  const candidateList = candidates.length
    ? candidates.map((c) => `#${c.number}: ${c.title}`).join('\n')
    : '(none)'

  const systemPrompt = `You are a GitHub issue triager for the Termdock project (a terminal app with AI agent integration). Analyze the issue below.

Step 1 — Spam check:
"spam" is true only when the issue is clearly not a genuine report or request about Termdock: advertising, gibberish, abuse, link farming, or content unrelated to any software project. A poorly written but genuine report is NOT spam.

Step 2 — Duplicate check:
Compare against the existing open issues listed below. Set "duplicate_of" to the issue number only when the new issue reports the same problem or requests the same feature. Similar area but different problem is NOT a duplicate.

Existing open issues:
${candidateList}

Step 3 — Labels (skip if spam or duplicate):
Available labels:
${labelDefs}

Classification rules:
1. Type: pick exactly one — bug / feature / refactor / documentation / research / question
2. Priority: pick one based on impact and urgency, or skip if unclear
3. Severity: only for bugs, pick one or skip
4. Scope: multi-select, pick all that apply
5. Cross-cutting concerns: multi-select, only pick when clearly relevant
6. Platform: pick if the issue mentions a specific OS or architecture

Return JSON only, no explanation:
{"spam": false, "duplicate_of": null, "labels": ["label1", "label2"]}
"duplicate_of" is a number or null. Only use label names from the list above.`

  const res = await fetch('https://api.mistral.ai/v1/chat/completions', {
    method: 'POST',
    headers: {
      Authorization: `Bearer ${MISTRAL_API_KEY}`,
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({
      model,
      response_format: { type: 'json_object' },
      messages: [
        { role: 'system', content: systemPrompt },
        {
          role: 'user',
          content: `Title: ${title}\n\nBody:\n${(body || '(no content)').slice(0, 4000)}`,
        },
      ],
      temperature: 0.1,
    }),
  })

  if (!res.ok) {
    const text = await res.text()
    throw new Error(`Mistral API: ${res.status} ${text}`)
  }

  const data = await res.json()
  const parsed = JSON.parse(data.choices[0].message.content)

  const validNames = new Set(allLabels.map((l) => l.name))
  const labels = (parsed.labels || []).filter((l) => validNames.has(l))
  const duplicateOf = Number.isInteger(parsed.duplicate_of) ? parsed.duplicate_of : null

  return { labels, spam: parsed.spam === true, duplicateOf }
}

// Keep user-applied labels authoritative: drop classified labels the issue
// already has, and drop the whole category for pick-one categories the user
// already covered.
function supplementLabels(classified, existing) {
  const existingSet = new Set(existing)
  const lockedCategories = PICK_ONE_CATEGORIES.filter((c) =>
    categoryLabels(c).some((name) => existingSet.has(name))
  )
  const lockedNames = new Set(lockedCategories.flatMap((c) => categoryLabels(c)))

  return classified.filter((l) => !existingSet.has(l) && !lockedNames.has(l))
}

async function applyLabels(number, labels) {
  if (labels.length === 0) return
  await ghApi(`/issues/${number}/labels`, {
    method: 'POST',
    body: JSON.stringify({ labels }),
  })
}

async function addComment(number, body) {
  await ghApi(`/issues/${number}/comments`, {
    method: 'POST',
    body: JSON.stringify({ body }),
  })
}

async function alreadySynced(number) {
  const comments = await ghApi(`/issues/${number}/comments?per_page=100`)
  return comments.some((c) => c.body && c.body.includes(SYNC_MARKER))
}

async function syncToInternal(issue, labels) {
  if (!INTERNAL_TOKEN || !config.sync) {
    console.log('  (no internal sync configured)')
    return
  }

  if (await alreadySynced(issue.number)) {
    console.log('  (already synced to internal, skipped)')
    return
  }

  const internalRepo = config.sync.repo
  const prefix = config.sync.prefix || '[external]'
  const externalUrl = `https://github.com/${owner}/${repo}/issues/${issue.number}`

  const internalBody = `${prefix} Synced from ${externalUrl}

**Original author**: @${issue.user.login}

---

${issue.body || '(no content)'}`

  const platformLabels = new Set(categoryLabels('platform'))
  const internalLabels = labels.filter((l) => !platformLabels.has(l))

  const res = await fetch(`https://api.github.com/repos/${internalRepo}/issues`, {
    method: 'POST',
    headers: {
      Authorization: `Bearer ${INTERNAL_TOKEN}`,
      Accept: 'application/vnd.github+json',
      'X-GitHub-Api-Version': '2022-11-28',
    },
    body: JSON.stringify({
      title: `${prefix} ${issue.title}`,
      body: internalBody,
      labels: internalLabels,
    }),
  })

  if (!res.ok) {
    const text = await res.text()
    console.error(`  ✗ Failed to create internal issue: ${res.status} ${text}`)
    return null
  }

  const internal = await res.json()
  console.log(`  → Internal issue: ${internal.html_url}`)

  await addComment(
    issue.number,
    `This issue is being tracked internally. Thank you for reporting!`
  )

  return internal
}

async function getIssue(number) {
  return ghApi(`/issues/${number}`)
}

async function listIssues(state) {
  const issues = []
  let page = 1
  while (true) {
    const batch = await ghApi(`/issues?state=${state}&per_page=100&page=${page}`)
    if (batch.length === 0) break
    issues.push(...batch.filter((i) => !i.pull_request))
    page++
  }
  return issues
}

async function processIssue(issue, { skipSync = false, candidates = [] } = {}) {
  const existingLabels = issue.labels.map((l) => l.name)

  // Maintainer-authored and official issues bypass the spam/duplicate gate.
  const trusted =
    existingLabels.includes('official') ||
    ['OWNER', 'MEMBER', 'COLLABORATOR'].includes(issue.author_association)

  const { labels, spam, duplicateOf } = await mistralClassify(
    issue.title,
    issue.body,
    candidates.filter((c) => c.number !== issue.number)
  )

  if (spam && !trusted) {
    console.log(`#${issue.number} "${issue.title}" → flagged as spam`)
    if (!dryRun) {
      await applyLabels(issue.number, ['invalid'])
      await addComment(
        issue.number,
        `Automated triage flagged this issue as invalid, so it was not forwarded to the internal tracker. If this is a genuine report, please add more details (steps to reproduce, expected behavior) and a maintainer will take a look.`
      )
    }
    return
  }

  if (duplicateOf && duplicateOf !== issue.number && !trusted) {
    console.log(`#${issue.number} "${issue.title}" → duplicate of #${duplicateOf}`)
    if (!dryRun) {
      await applyLabels(issue.number, ['duplicate'])
      await addComment(
        issue.number,
        `This looks like a duplicate of #${duplicateOf}, so it was not forwarded separately. If it describes a different problem, please explain the difference and a maintainer will re-triage.`
      )
    }
    return
  }

  const toAdd = supplementLabels(labels, existingLabels)
  console.log(
    `#${issue.number} "${issue.title}" → classified [${labels.join(', ')}], adding [${toAdd.join(', ')}]`
  )

  if (dryRun) {
    console.log(`  (dry-run, not applied)`)
    return
  }

  if (toAdd.length > 0) {
    await applyLabels(issue.number, toAdd)
    console.log(`  ✓ Labeled`)
  }

  if (!skipSync) {
    await syncToInternal(issue, labels)
  }
}

async function main() {
  console.log(`Mode: ${dryRun ? 'dry-run' : 'live'}`)
  console.log(`Model: ${model}`)

  if (issueNumber) {
    const [issue, openIssues] = await Promise.all([
      getIssue(issueNumber),
      listIssues('open'),
    ])
    const candidates = openIssues.map((i) => ({ number: i.number, title: i.title }))
    await processIssue(issue, { candidates })
  } else {
    const issues = await listIssues(issueState)
    console.log(`Total: ${issues.length} ${issueState} issues`)
    const candidates = issues.map((i) => ({ number: i.number, title: i.title }))

    for (let i = 0; i < issues.length; i++) {
      await processIssue(issues[i], { skipSync: true, candidates })
      if (i < issues.length - 1) {
        await new Promise((r) => setTimeout(r, config.rate_limit_delay_ms))
      }
    }
  }

  console.log('Done')
}

main().catch((err) => {
  console.error(err)
  process.exit(1)
})
