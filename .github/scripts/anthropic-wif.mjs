// Claude API through workload identity federation: the GitHub Actions OIDC token is exchanged
// for a short-lived access token, so no API key is stored. The Claude Console federation rule
// accepts only this repo's main branch. Its IDs are repo secrets.
import { mkdirSync, writeFileSync } from 'fs'
import { join } from 'path'
import Anthropic from '@anthropic-ai/sdk'

const AUDIENCE = 'https://api.anthropic.com'
const WIF_VARIABLES = [
  'ANTHROPIC_FEDERATION_RULE_ID',
  'ANTHROPIC_ORGANIZATION_ID',
  'ANTHROPIC_SERVICE_ACCOUNT_ID',
  'ANTHROPIC_WORKSPACE_ID',
]
// Any of these, even empty, would override WIF in the SDK. Refuse instead of falling back.
const AUTH_OVERRIDES = ['ANTHROPIC_API_KEY', 'ANTHROPIC_AUTH_TOKEN', 'ANTHROPIC_PROFILE', 'ANTHROPIC_BASE_URL']
// GitHub OIDC tokens expire in about 5 minutes. The SDK rereads the file on each exchange,
// so batch mode refreshes the file.
const IDENTITY_REFRESH_MS = 4 * 60 * 1000

let identityFetchedAt = 0

async function fetchGithubIdentityToken() {
  const url = process.env.ACTIONS_ID_TOKEN_REQUEST_URL
  const requestToken = process.env.ACTIONS_ID_TOKEN_REQUEST_TOKEN
  if (!url || !requestToken) throw new Error('No GitHub OIDC token: the workflow needs permissions.id-token: write')
  const res = await fetch(`${url}&audience=${encodeURIComponent(AUDIENCE)}`, {
    headers: { Authorization: `Bearer ${requestToken}` },
  })
  if (!res.ok) throw new Error(`GitHub OIDC token request failed: ${res.status}`)
  const { value } = await res.json()
  if (typeof value !== 'string' || !value) throw new Error('GitHub returned no OIDC token')
  console.log(`::add-mask::${value}`)
  return value
}

export async function refreshIdentityToken() {
  if (Date.now() - identityFetchedAt < IDENTITY_REFRESH_MS) return
  writeFileSync(process.env.ANTHROPIC_IDENTITY_TOKEN_FILE, await fetchGithubIdentityToken(), { mode: 0o600 })
  identityFetchedAt = Date.now()
}

export async function createWifClient() {
  const overrides = AUTH_OVERRIDES.filter((name) => process.env[name] !== undefined)
  if (overrides.length) throw new Error(`Remove ${overrides.join(', ')}: this workflow uses WIF only`)
  const missing = WIF_VARIABLES.filter((name) => !process.env[name]?.trim())
  if (missing.length) throw new Error(`Missing repo secrets: ${missing.join(', ')}`)

  // Empty SDK config directory, so no existing profile on the runner is used
  const dir = join(process.env.RUNNER_TEMP || '.', `anthropic-wif-${process.pid}`)
  mkdirSync(dir, { mode: 0o700 })
  process.env.ANTHROPIC_CONFIG_DIR = dir
  process.env.ANTHROPIC_IDENTITY_TOKEN_FILE = join(dir, 'identity.jwt')
  await refreshIdentityToken()

  return new Anthropic({ baseURL: AUDIENCE, timeout: 45_000, maxRetries: 2 })
}
