# Codex Task Card

## Goal

One objective only.

## Non-goals

- Do not solve unrelated issues.
- Do not change forbidden paths.
- Do not perform production/destructive actions unless explicitly authorized.
- Do not write or expose secrets.

## Canonical repo / workspace

- Path: `<absolute path>`
- Branch: `<branch>`
- Active owner: Codex implements; OpenClaw/Hermes supervises and verifies.

## Allowed scope

- Files / directories Codex may modify:
  - `<path>`

## Forbidden actions

- No secrets/API keys in prompts, logs, or commits.
- No public posting or external messaging.
- No destructive DB writes.
- No unrelated refactors or dependency changes.

## Context

Minimal facts Codex needs:

- ...

## Verification gate

OpenClaw/Hermes will accept only with evidence from at least one:

- `git diff --stat` and relevant diff review
- test/build command:
  - `<command>`
- script dry-run:
  - `<command>`
- DB read-only query:
  - `<query>`
- runtime/browser/log check:
  - `<check>`

## Rollback note

- Revert changed files with git or restore from backup.
- Do not delete user data.

## Required Codex output

Return:

- changed files
- summary of changes
- verification commands run and exact results
- blockers / risks
- next recommended action
