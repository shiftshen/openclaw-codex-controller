# OpenClaw Codex Controller

OpenClaw Codex Controller is an OpenClaw skill package that turns OpenClaw Main into an AI project manager for Codex CLI work: Main registers projects, packages code, issues exact task cards, supervises progress, and verifies delivery; Codex works only inside the assigned sandbox.

OpenClaw Codex Controller 是一个 OpenClaw 技能包，用于把 OpenClaw Main 固化成 AI 项目经理：Main 负责项目登记、代码打包、发号施令、进度监督和验收；Codex 只在指定沙箱内完成明确任务。

## What it does / 作用

- Manage Codex execution modes: planning, implementation, review, queue dispatch, and supervised follow-up.
- Enforce one objective per Codex run, with explicit repo, branch, allowed scope, non-goals, and rollback notes.
- Enforce Anti-Drift rules so every run is locked to one goal and one allowed change boundary.
- Document Codex CLI command patterns and pitfalls for `--ephemeral`, `-C`, `--add-dir`, sandbox modes, JSONL capture, review, and MCP/plugin inspection.
- Define delivery gates for code changes, UI work, runtime checks, tests, artifacts, and final reports.
- Provide reusable task-card templates for normal engineering work and frontend/UIUX work.

- 管理 Codex 执行模式：目标模式、计划模式、执行模式、评审模式、列队模式。
- 强制每次 Codex 只处理一个目标，并写清 repo、branch、可改范围、非目标和回滚说明。
- 强制防漂移：单次任务锁定单一目标、单一范围、单一验收门槛，禁止发散式改造。
- 固化 Codex 命令使用大全与避坑指南，包括 `--ephemeral`、`-C`、`--add-dir`、sandbox、JSONL、review、MCP/plugin 检查。
- 设定交付标准：diff、测试、运行检查、浏览器验证、产物路径、风险说明。
- 提供可复用任务卡模板，包括通用工程任务和前端/UIUX 任务。

## Operating model / 协作模型

Main is the project manager. Codex is the sandbox worker.

Main 是项目经理，Codex 是沙箱执行工。

- Main: database/state registration, repo packaging, GitHub handoff, task-card dispatch, progress control, verification, final commit/push decision.
- Codex: bounded file edits, required commands, minimum verification, evidence report, blocker/risk report.
- Main: 数据库/状态登记、仓库打包、GitHub 交接、任务卡派发、进度控制、验收、最终 commit/push 决策。
- Codex: 只做限定文件修改、执行指定命令、完成最小验证、回报证据、阻塞和风险。

## Package contents / 包内容

```text
SKILL.md
templates/
  task-card.md
  frontend-uiux-task-card.md
references/
  codex-cli-study.md
  verification-gates.md
install.sh
```

## Installation / 安装

Set `OPENCLAW_WORKSPACE` to the target OpenClaw workspace, then run:

设置 `OPENCLAW_WORKSPACE` 为目标 OpenClaw 工作区，然后执行：

```bash
OPENCLAW_WORKSPACE=/path/to/openclaw/workspace ./install.sh
```

The installer copies:

安装脚本会复制：

- `SKILL.md` -> `$OPENCLAW_WORKSPACE/skills/codex-controller/SKILL.md`
- `templates/` -> `$OPENCLAW_WORKSPACE/skills/codex-controller/templates/`

It does not copy `.git`, write secrets, or modify unrelated projects.

脚本不会复制 `.git`，不会写入密钥，也不会修改无关项目。

## Usage / 使用

Use this skill when OpenClaw, Hermes, or another supervisor needs Codex to perform professional engineering work instead of open-ended chat.

当 OpenClaw、Hermes 或其他主控节点需要 Codex 做专业工程执行，而不是泛泛聊天时，使用此技能。

Recommended flow:

推荐流程：

1. Choose the mode: goal, planning, queue, guided, implementation, or review.
2. Create a task card from `templates/task-card.md` or `templates/frontend-uiux-task-card.md`.
3. Dispatch Codex with the exact repo path and sandbox mode.
4. Verify the diff, tests, runtime behavior, and artifacts before marking the task done.

Minimal safe dispatch:

```bash
codex exec --ignore-rules --ephemeral \
  -C /absolute/path/to/repo \
  -s workspace-write \
  -o /absolute/path/to/tmp/codex.out \
  - < /absolute/path/to/task-card.md
```

Use `-s read-only` for study/planning/review. Use `--add-dir` only when the task card explicitly allows the extra path. Capture `--json` to a log file when Main needs machine-readable progress evidence.

## Delivery standard / 交付标准

A Codex task is complete only when the supervisor can verify:

Codex 任务只有在主控节点能确认以下内容时才算完成：

- changed files are inside the allowed scope
- no drift occurred beyond the single stated goal
- no secrets are exposed
- required tests or runtime checks were run
- UI work includes browser or screenshot evidence when applicable
- blockers and risks are stated directly

## License / 许可证

Add the repository license before public release.
