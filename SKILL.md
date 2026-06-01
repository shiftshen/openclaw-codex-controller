---
name: codex-controller
description: "OpenClaw main runbook for professional Codex CLI operation: study/help/config/features, task dispatch, supervised implementation, code review, frontend/UIUX lanes, evidence gates, and project-development handoff."
---

# Codex Controller — OpenClaw Main Runbook

Use this skill whenever OpenClaw main, Hermes, or another agent needs to use Codex professionally for project development, code review, debugging, frontend/page design, UI implementation, or multi-step engineering work.

This is not a generic "ask Codex" note. It is the canonical OpenClaw control loop for **熟练、专业、可验收地使用 Codex**.

## Current studied Codex baseline

Verified on this machine:

- Codex CLI: `codex-cli 0.130.0`
- Config path: `/Users/shift/.codex/config.toml`
- Skill root for Codex workers: `/Users/shift/.codex/skills`
- OpenClaw main workspace: `/Users/shift/openclaw/workspace-xmanx`
- Official help capture: `/Users/shift/openclaw/workspace-xmanx/tmp/codex-official-study-2026-05-26/`
- UI/UX Pro Max Codex skill: `/Users/shift/.codex/skills/ui-ux-pro-max/SKILL.md`
- UI/UX Pro Max search/design-system script: `/Users/shift/.codex/skills/ui-ux-pro-max/scripts/search.py`

Sensitive values from `login status` or config must never be pasted into reports. Redact API keys/tokens as `[REDACTED]`.

## Non-negotiable operating principles

1. **Hermes/OpenClaw governs; Codex implements.** Do not let Codex define scope alone.
2. **One objective per Codex run.** Split large projects into task cards.
3. **No blind acceptance.** Codex output is candidate-only until OpenClaw verifies diff, tests, runtime/browser behavior, and artifacts.
4. **No secret leakage.** Do not paste API keys, tokens, passwords, cookies, `.env` values, or private connection strings into prompts, logs, reports, or commits.
5. **Exact workspace control.** Always set `-C /absolute/repo/path`; add explicit writable directories with `--add-dir` only when required.
6. **Sandbox defaults.** Use `-s read-only` for study/planning/review, `-s workspace-write` for implementation, and avoid `danger-full-access` unless the human explicitly authorizes a contained environment.
7. **Frontend/UI work must use UI/UX Pro Max first.** No page, component, dashboard, landing page, Tailwind/CSS, chart UI, mobile UI, or visual redesign can be implemented from default aesthetics.
8. **Codex continuity is supervisor-owned.** A live project must not depend on the human sending another message before the next Codex task is dispatched.
9. **Conversation interruption is not a stop signal.** Unless the human pauses, stops, or changes priority, OpenClaw should preserve the Codex queue and continue with the next smallest high-value task on its own cadence.
10. **Codex is an independent project lane.** Treat the Codex skill, templates, queue ledger, and verification loop as a maintained control plane, not a one-shot helper.

## Codex CLI command map

From `codex --help`:

- `codex exec` / `codex e` — non-interactive implementation/planning worker.
- `codex review` — non-interactive code review.
- `codex login status` — verify auth; redact key fragments.
- `codex mcp list|get|add|remove|login|logout` — inspect/manage Codex MCP servers.
- `codex plugin marketplace ...` — inspect/manage plugin marketplaces.
- `codex features list` — inspect stable/experimental feature flags.
- `codex sandbox` — run commands inside Codex sandbox.
- `codex apply` — apply latest diff from a Codex session; use only after review.
- `codex resume` / `codex fork` — continue or branch interactive sessions when needed.
- `codex cloud` — experimental Cloud task browser; do not make it a default OpenClaw path without explicit reason.

Useful `codex exec` flags:

- `-C, --cd <DIR>`: required; sets target repo/work root.
- `-s, --sandbox read-only|workspace-write|danger-full-access`: choose deliberately.
- `--add-dir <DIR>`: grant additional writable path, e.g. Codex skill root.
- `--ephemeral`: avoid persisting session files for one-off checks.
- `--ignore-rules`: bypass user/project execpolicy only when OpenClaw already owns the safety envelope.
- `--skip-git-repo-check`: only for non-git temp/workspace tasks.
- `--json`: emit JSONL events for machine parsing.
- `-o, --output-last-message <FILE>`: save final Codex answer as an artifact.
- `--output-schema <FILE>`: force structured final response when the acceptance gate needs a schema.
- `-i, --image <FILE>`: attach images/screenshots for visual UI/debug tasks.
- `-c key=value`, `--enable`, `--disable`: controlled config/feature override.

## Standard OpenClaw → Codex workflow

1. **Study context first**
   - Read project state (`PROJECT_STATE.md`, README, docs, AGENTS/CLAUDE/CODEX rules if present).
   - Run `git status --short --branch`.
   - Identify current branch and dirty files.
   - Identify exact allowed scope and forbidden files.

2. **Choose working mode**
   - `目标模式`: clarify objective, acceptance, non-goals. Use before any implementation.
   - `计划模式`: ask Codex for a plan only using `-s read-only`; no file writes.
   - `列队模式`: split a project into sequential task cards with dependencies.
   - `引导模式`: provide a known workflow/skill path and require Codex to follow it exactly.
   - `执行模式`: one task card, workspace-write, evidence-required.
   - `评审模式`: `codex review` or `codex exec review`, then OpenClaw verifies findings.

3. **Create a task card**
   - Use `templates/task-card.md` or `templates/frontend-uiux-task-card.md`.
   - Include exact repo/path, branch, allowed scope, non-goals, verification gate, rollback, output format.
   - For frontend/UI work, inject the UI/UX Pro Max lane below.

4. **Dispatch Codex**
   - Save prompt to a file under `tmp/` or project notes.
   - Prefer stdin: `codex exec ... - < task.md` to avoid shell quoting mistakes.
   - Use background process with notification for long implementation.

5. **Supervise and verify**
   - Inspect Codex output.
   - Inspect `git diff --stat` and relevant diff.
   - Re-run the exact verification gate yourself.
   - For user-visible UI/runtime changes, run browser/app verification; screenshots/logs count only as supporting evidence, not sole proof.

6. **Promote the next task without waiting for a nudge**
   - If the current task is `done`, immediately identify the next smallest high-value task and dispatch it unless a real blocker or user stop exists.
   - If the current task is `partial`, isolate the remaining gap into a narrower follow-up card and dispatch it.
   - If the current task is `blocked`, record the blocker explicitly and continue another unblocked queue item where possible.
   - Do not require a fresh user message to keep the Codex lane alive.

7. **Record and report**
   - Update project state/report with exact commands, exit codes, stdout/stderr summary, changed files, artifacts, timestamp.
   - Verdict must be one of: `done`, `partial`, `blocked`.

## Dispatch command templates

### Read-only planning / study

```bash
codex exec --ignore-rules --ephemeral   -C /absolute/path/to/repo   -s read-only   -o /absolute/path/to/tmp/codex-plan.out   - < /absolute/path/to/tmp/task-card.md
```

### Implementation in repo

```bash
codex exec --ignore-rules --ephemeral   -C /absolute/path/to/repo   -s workspace-write   -o /absolute/path/to/tmp/codex-impl.out   - < /absolute/path/to/tmp/task-card.md
```

### Implementation that must also edit a skill directory

```bash
codex exec --ignore-rules --ephemeral   -C /absolute/path/to/repo   --add-dir /Users/shift/.codex/skills   --add-dir /Users/shift/openclaw/workspace-xmanx/skills   -s workspace-write   -o /absolute/path/to/tmp/codex-skill-update.out   - < /absolute/path/to/tmp/task-card.md
```

### JSONL capture for later parsing

```bash
codex exec --ignore-rules --ephemeral --json   -C /absolute/path/to/repo   -s workspace-write   - < /absolute/path/to/tmp/task-card.md   > /absolute/path/to/logs/codex-events.jsonl
```

### Code review

```bash
codex review --uncommitted -C /absolute/path/to/repo   'Review for correctness, security, regressions, missing tests, and user-visible behavior gaps.'
```

If the installed `review` command does not accept `-C` in this version, run from the repo:

```bash
cd /absolute/path/to/repo
codex review --uncommitted 'Review for correctness, security, regressions, missing tests, and user-visible behavior gaps.'
```

## Frontend/UI/UX Pro Max mandatory lane

Trigger this lane for any task mentioning frontend, page, landing page, dashboard, component, UI, UX, CSS, Tailwind, visual redesign, mobile app UI, chart/data-viz UI, layout, responsive design, interaction states, animation, or accessibility.

Before Codex writes UI code, the task card must require:

```bash
# 1. Read the Codex UI/UX skill.
sed -n '1,220p' /Users/shift/.codex/skills/ui-ux-pro-max/SKILL.md

# 2. Generate and persist a design system in the target project.
python3 /Users/shift/.codex/skills/ui-ux-pro-max/scripts/search.py   "<product industry audience style density>"   --design-system --persist   -p "<Project Name>"   --page "<page-or-feature-name>"   -f markdown

# 3. Read the persisted design files before implementation.
sed -n '1,240p' design-system/<project-slug>/MASTER.md
sed -n '1,240p' design-system/<project-slug>/pages/<page-or-feature-name>.md 2>/dev/null || true
```

Implementation must reflect the design system:

- pattern and information architecture
- style direction
- color palette and semantic tokens
- typography and scale
- spacing rhythm and layout density
- states: hover, focus, pressed, disabled, loading, empty, error
- responsiveness: small phone/tablet/desktop as applicable
- accessibility: contrast, labels, keyboard/focus, reduced motion
- anti-patterns explicitly avoided

Codex final output for UI work must include:

- design-system file paths generated/read
- changed UI files
- verification commands and exact results
- screenshot/browser/app check evidence when applicable
- remaining visual risks or responsive gaps

## Skill-learning / conversion workflow

When the user asks to "learn Codex", "convert Codex skills", "install Codex skill", or "make OpenClaw use Codex professionally":

1. Capture official help locally:
   - `codex --help`
   - `codex exec --help`
   - `codex review --help`
   - `codex mcp --help`
   - `codex plugin --help`
   - `codex features list`
2. Inspect current Codex paths:
   - `command -v codex`
   - `codex --version`
   - `codex login status` (redacted in reports)
   - `codex mcp list` (redact env values)
   - `~/.codex/config.toml` (redact credentials)
   - `/Users/shift/.codex/skills/*/SKILL.md`
3. Convert useful procedures into OpenClaw skills under the correct workspace skill directory.
4. Create templates/references/scripts under the skill directory, not scattered notes.
5. Smoke-test both Codex itself and any installed skill scripts.
6. Write an evidence report with exact command exits and artifact paths.

## Continuous operation contract

Use this skill as a persistent supervisor lane, not a turn-by-turn chat helper.

### Single-project continuity rule

When Shift declares a canonical GitHub repo/project lane for Codex, do **not** keep reframing follow-up work as new projects. Continue inside the same repo/project unless Shift explicitly changes the project.

Required behavior:
- keep the same canonical repo, north-star, test environment, and acceptance boundary
- treat new task cards as **continuations of the same project**, not new project launches
- when the repo uses a remote acceptance host, keep that host stable in every follow-up card
- separate responsibilities clearly:
  - **Codex** owns development inside the target GitHub project repo
  - **OpenClaw main** owns Codex skill improvement, prompting/communication repair, supervision, and verification
- if Codex keeps hitting the same coordination mistake, fix the task-card pattern / supervisor behavior / skill instructions instead of blaming Codex
- when Shift requires proactive reporting, do **not** wait for a follow-up ping; after each meaningful checkpoint, send a progress report with: current stage, changed evidence, remote-test status, blocker, and next action
- a failed/empty user-facing update is itself a defect: immediately retry with a plain concise report, then inspect and repair the Codex/OpenClaw reporting pattern so the same silent failure does not repeat
- when Shift explicitly requires **proactive progress reporting**, treat it as a deliverable of the project lane itself: after each meaningful checkpoint, send a separate concise progress update without waiting for another user message; if channel constraints prevent true proactive send from the current path, surface that as a blocker immediately instead of pretending reply-mode equals proactive reporting

For the current company-management lane, the canonical example is:
- project repo: `https://github.com/shiftshen/openclaw-company-management`
- remote acceptance host: `192.168.1.83`
- remote host must use **GitHub-sourced files** for project runtime checks
- Codex may change only the project repo and the project-related config/files on `192.168.1.83` needed for testing
- OpenClaw main must not drift into owning the repo implementation work itself; its lane is Codex-skill/process improvement and acceptance management

### When to continue automatically

Continue dispatching/supervising Codex without waiting for a new human message when all of the following are true:

- there is an active project line with a clear north-star
- no explicit user stop/pause/reprioritization has been given
- the next task can be bounded safely
- the next task stays inside the approved repo/scope

Examples:
- a feature slice finished and the next slice is obvious
- verification passed and the next queue item is already known
- one task blocked on platform approval, but another local/product/documentation/deploy-readiness slice is still actionable

### When to stop and ask

Pause and ask only when one of these is true:

- an irreversible/destructive action is required
- scope must expand beyond the stated repo/system boundary
- credentials, access, or product direction are genuinely missing
- two or more reasonable next directions exist and the tradeoff materially affects product priority
- the human explicitly said stop, pause, or changed the priority

### Interruption recovery rule

If the chat goes quiet, another conversation intervenes, or a subtask report arrives later:

1. recover the canonical project state
2. recover the active Codex queue item and latest evidence
3. verify whether the latest child result is real, partial, blocked, or stale
4. dispatch the next smallest valid Codex task if work remains
5. only then send a progress update on the normal cadence or when asked

Silence from the human is **not** a cancellation signal.

## Supervision checklist

Before dispatch:

- [ ] Correct repo/path and branch identified.
- [ ] Dirty tree reviewed; user work protected.
- [ ] Task card has one goal and explicit non-goals.
- [ ] Allowed and forbidden scopes are stated.
- [ ] Sandbox mode is appropriate.
- [ ] Secrets are not in prompt.
- [ ] UI/UX lane included when frontend/user-visible UI is touched.

After Codex returns:

- [ ] `git status --short` reviewed.
- [ ] `git diff --stat` reviewed.
- [ ] Relevant diff reviewed for scope drift and secret leakage.
- [ ] Verification commands re-run by OpenClaw/Hermes, not just trusted from Codex.
- [ ] Browser/runtime/app check performed for user-visible behavior.
- [ ] Report includes exit codes, stdout/stderr summary, paths, and timestamp.

## Codex to Main Notification Protocol (The 4-State Loop)

Whenever Codex is dispatched on a project, it MUST report its progress back to `main` using exactly these 4 states via the `agent_bus` or direct project logs. Do not use generic unstructured chatting.

1) **acknowledged**
   - 已接单 (Received task)
   - 理解目标 (Understood objective)
   - 准备改哪些文件 (Which files will be modified)

2) **in_progress**
   - 正在改什么 (What is being modified right now)
   - 当前检查什么 (What is being checked/tested)
   - 是否有风险 (Are there any risks)

3) **blocked**
   - 卡在哪 (Where is it stuck)
   - 试了什么 (What has been tried)
   - 需要谁做什么 (Who needs to do what to unblock)

4) **completed**
   - 改了什么 (What was actually changed)
   - 验证了什么 (What was verified)
   - 剩余风险是什么 (What are the remaining risks)

`main` is then responsible for translating these structured states into human-readable progress reports for the user.

## Fallback chain when quota exhausted

When codex exec returns 429 (quota exceeded) or provider error:

```bash
# 1. First retry with cheaper model on same provider
echo "429 detected, retrying with gpt-5.4-mini..."
codex exec --ignore-rules --ephemeral   -C /absolute/path/to/repo   -s read-only   --model "gpt-5.4-mini"   -o /tmp/codex-fallback.out   - < /tmp/task-card.md

# 2. If still fails, switch to local antigravity model
echo "Switch to local antigravity..."
codex exec --ignore-rules --ephemeral   -C /absolute/path/to/repo   -s read-only   --model "gemini-2.5-flash"   -o /tmp/codex-fallback.out   - < /tmp/task-card.md

# 3. Final fallback: local budget model
echo "Final fallback to gemini-3.5-flash-extra-low..."
codex exec --ignore-rules --ephemeral   -C /absolute/path/to/repo   -s read-only   --model "gemini-3.5-flash-extra-low"   -o /tmp/codex-fallback.out   - < /tmp/task-card.md
```

## Cost-saving model selection

Reference the dev-tools-strategy skill for model selection by task type:

| Task type | Preferred model | Cost |
|---|---|---|
| Chinese/SEA language | localhost:8080 gemini-claude | Free |
| Code planning/review | gemini-2.5-flash-lite (local) | Free |
| Complex code impl | claude-opus-4-6 (local/192.168) | Free |
| Frontend/UI | gpt-5.4-mini (Plus) | Free (Plus tier) |
| High-precision reasoning | gpt-5.5 (Plus) | Free (Plus tier) |
| Batch/simple tasks | gemini-3.5-flash-extra-low | Free |
| Catch-all | deepseek-v4-flash | Paid (token bought) |

**Hard rule:** Never default to the most expensive model. Always start with the cheapest suitable model for the task.

## Failure handling

- If Codex fails due to config parser errors, inspect `/Users/shift/.codex/config.toml`; current custom providers require `wire_api = "responses"`.
- If provider returns account/pool errors, Codex config may still be syntactically valid; debug provider availability separately.
- If optional MCP/plugin auth errors appear but model call succeeds, do not misdiagnose as model config failure.
- If Codex expands scope, stop and re-dispatch with a narrower task card.
- If verification fails, mark `partial` or `blocked`; do not report done.
- If a long Codex process hangs, capture log/output, terminate it, and finish the task manually or with a smaller prompt.
- If a child task times out after making useful progress, do not leave the lane idle: recover the evidence, accept/reject only what is verified, then immediately issue a narrower recovery task.
- If a child task completes with weak/no summary, supervisor must inspect diff, logs, tests, and runtime results directly before deciding the verdict.
- If the human complains that Codex only moves after being pinged, treat that as a control-plane failure and fix the queue/cadence behavior before resuming normal project work.

## Acceptance verdict format

```text
verdict: done|partial|blocked
goal:
repo/path:
branch:
changed_files:
verification:
  - command:
    exit_code:
    stdout/stderr_summary:
artifacts:
risks:
next_action:
timestamp:
```

## Supporting files

- `templates/task-card.md` — general Codex task card.
- `templates/frontend-uiux-task-card.md` — mandatory UI/UX Pro Max frontend task card.
- `references/codex-cli-study.md` — studied official CLI help and current local Codex capability map.
- `references/verification-gates.md` — acceptance gates and evidence patterns.

---

## Merged: Codex Supervisor Rules

(从 `codex-supervisor` skill 合并)

### Core rules
- One active goal, one active owner, one evidence gate.
- Codex does implementation; this skill owns planning, dispatch, follow-up, verification, and timed supervision.
- Do not write product code directly from this supervisor loop unless Shift explicitly overrides.
- Never accept status-only updates as completion.
- If one module is blocked, isolate it and continue the rest of the project.
- For frontend/page/component work, require `ui-ux-pro-max` before tasking or reviewing UI work.
- Before dispatching Codex, select one operating mode: `goal`, `plan`, `queue`, or `guided`.

### Operating modes

**`goal` mode:** Target clear, scope small, direct verification. Dispatch a focused Codex task. Supervisor verifies diff + test/runtime/browser evidence.

**`plan` mode:** Work unclear, risky, or broad. Codex reads-only first, outputs evidence/options/risks. After planning, convert to another mode.

**`queue` mode:** Multiple tasks with dependencies. Each item must have: id, goal, dependency, scope, verification gate, rollback, status, evidence. Promote the next highest-value unblocked item when one finishes or blocks.

**`guided` mode:** Explicit skill/template/guide reference provided to Codex before execution.

---

## Merged: Codex Completion Verifier Rules

(从 `codex-completion-verifier` skill 合并)

Before accepting any Codex task as done:
1. Read the claimed outcome and expected user behavior.
2. Inspect code, logs, and artifacts for evidence.
3. If the task touches a browser flow, UI, login, routing, or user-facing screen, pass a real browser test using `browser-profile-ops` before accepting completion.
4. Accept only when evidence and real test agree.
5. If browser verification is unavailable or fails, the task stays `partial` or `blocked`.

---

## Merged: Codex Project Manager Rules

(从 `codex-project-manager` skill 合并)

For long-running Codex-assisted projects with durable state:
- Project state file: `projects/<project-name>/PROJECT_STATE.md`
- Treat the project state file as the single current coordination surface.
- Do not rely on chat history as the source of truth.
- Reading the project state file first: check goal, repo/path, branch, active owner, current stage, latest evidence, blocker, next action, next check time, last report key.
- Route final acceptance through the verifier rules above before saying done.
