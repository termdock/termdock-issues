import { readFileSync } from 'fs'
import { parse } from 'yaml'

const GITHUB_TOKEN = process.env.GITHUB_TOKEN
const MISTRAL_API_KEY = process.env.MISTRAL_API_KEY
const INTERNAL_TOKEN = process.env.INTERNAL_REPO_TOKEN
const GITHUB_REPOSITORY = process.env.GITHUB_REPOSITORY
const [owner, repo] = GITHUB_REPOSITORY.split('/')

const config = parse(readFileSync('.github/label-config.yml', 'utf8'))

const issueNumber = process.env.INPUT_ISSUE_NUMBER
  ? parseInt(process.env.INPUT_ISSUE_NUMBER)
  : null
const issueState = process.env.INPUT_STATE || 'open'
const dryRun = process.env.INPUT_DRY_RUN === 'true'

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

async function mistralClassify(title, body) {
  const allLabels = [
    ...config.labels.type,
    ...config.labels.priority,
    ...config.labels.severity,
    ...config.labels.scope,
    ...config.labels.concern,
    ...(config.labels.platform || []),
  ]

  const labelDefs = allLabels
    .map((l) => {
      let line = `- "${l.name}": ${l.description}`
      if (l.criteria) line += ` (criteria: ${l.criteria})`
      return line
    })
    .join('\n')

  const systemPrompt = `You are a GitHub issue/PR classifier. Based on the title and content, select the most appropriate labels from the list below.

Available labels:
${labelDefs}

Classification rules:
1. Type: pick exactly one — bug / feature / refactor / documentation / research / question
2. Priority: pick one based on impact and urgency, or skip if unclear
3. Severity: only for bugs, pick one or skip
4. Scope: multi-select, pick all that apply
5. Cross-cutting concerns: multi-select, only pick when clearly relevant
6. Platform: pick if the issue mentions a specific OS or architecture

Return JSON only: {"labels": ["label1", "label2"]}
Only use label names from the list above. No explanation.`

  const res = await fetch('https://api.mistral.ai/v1/chat/completions', {
    method: 'POST',
    headers: {
      Authorization: `Bearer ${MISTRAL_API_KEY}`,
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({
      model: config.model,
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
  const content = data.choices[0].message.content
  const parsed = JSON.parse(content)

  const validNames = new Set(allLabels.map((l) => l.name))
  const labels = (parsed.labels || []).filter((l) => validNames.has(l))

  return labels
}

async function applyLabels(number, labels) {
  if (labels.length === 0) return
  await ghApi(`/issues/${number}/labels`, {
    method: 'POST',
    body: JSON.stringify({ labels }),
  })
}

async function syncToInternal(issue, labels) {
  if (!INTERNAL_TOKEN || !config.sync) {
    console.log('  (no internal sync configured)')
    return
  }

  const internalRepo = config.sync.repo
  const prefix = config.sync.prefix || '[external]'
  const externalUrl = `https://github.com/${owner}/${repo}/issues/${issue.number}`

  const internalBody = `${prefix} Synced from ${externalUrl}

**Original author**: @${issue.user.login}

---

${issue.body || '(no content)'}`

  const internalLabels = labels.filter((l) => {
    const platformLabels = (config.labels.platform || []).map((p) => p.name)
    return !platformLabels.includes(l)
  })

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

  await ghApi(`/issues/${issue.number}/comments`, {
    method: 'POST',
    body: JSON.stringify({
      body: `This issue is being tracked internally. Thank you for reporting!`,
    }),
  })

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

async function processIssue(issue, { skipSync = false } = {}) {
  const existingLabels = issue.labels.map((l) => l.name)
  const managedCategories = [
    ...config.labels.type.map((l) => l.name),
    ...config.labels.priority.map((l) => l.name),
    ...config.labels.severity.map((l) => l.name),
    ...config.labels.scope.map((l) => l.name),
    ...config.labels.concern.map((l) => l.name),
    ...(config.labels.platform || []).map((l) => l.name),
  ]
  const hasAutoLabels = existingLabels.some((l) => managedCategories.includes(l))

  if (hasAutoLabels) {
    console.log(`#${issue.number} already labeled [${existingLabels.join(', ')}], skipped`)
    return
  }

  const labels = await mistralClassify(issue.title, issue.body)
  console.log(`#${issue.number} "${issue.title}" → [${labels.join(', ')}]`)

  if (!dryRun && labels.length > 0) {
    await applyLabels(issue.number, labels)
    console.log(`  ✓ Labeled`)

    if (!skipSync) {
      await syncToInternal(issue, labels)
    }
  } else if (dryRun) {
    console.log(`  (dry-run, not applied)`)
  }
}

async function main() {
  console.log(`Mode: ${dryRun ? 'dry-run' : 'live'}`)
  console.log(`Model: ${config.model}`)

  if (issueNumber) {
    const issue = await getIssue(issueNumber)
    await processIssue(issue)
  } else {
    const issues = await listIssues(issueState)
    console.log(`Total: ${issues.length} ${issueState} issues`)

    for (let i = 0; i < issues.length; i++) {
      await processIssue(issues[i], { skipSync: true })
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
