# Codex CLI Study Notes

Captured: 2026-05-26T11:37:51+0700

Source artifacts:

- `/Users/shift/openclaw/workspace-xmanx/tmp/codex-official-study-2026-05-26/codex-help.txt`
- `/Users/shift/openclaw/workspace-xmanx/tmp/codex-official-study-2026-05-26/codex-exec-help.txt`
- `/Users/shift/openclaw/workspace-xmanx/tmp/codex-official-study-2026-05-26/codex-review-help.txt`
- `/Users/shift/openclaw/workspace-xmanx/tmp/codex-official-study-2026-05-26/codex-mcp-help.txt`
- `/Users/shift/openclaw/workspace-xmanx/tmp/codex-official-study-2026-05-26/codex-plugin-help.txt`
- `/Users/shift/openclaw/workspace-xmanx/tmp/codex-official-study-2026-05-26/codex-features-list.txt`
- `/Users/shift/openclaw/workspace-xmanx/tmp/codex-official-study-2026-05-26/codex-config-sanitized.toml`

## Verified local facts

- `codex --version`: `codex-cli 0.130.0`
- `codex exec` reads prompt from stdin when prompt is omitted or `-` is used.
- `codex exec -o FILE` writes the final message to a file.
- `codex exec --json` writes JSONL events to stdout.
- `codex exec --ephemeral` avoids persistent session files.
- Sandbox options are `read-only`, `workspace-write`, `danger-full-access`.
- Current stable enabled features include apps, browser_use, browser_use_external, computer_use, fast_mode, guardian_approval, hooks, image_generation, in_app_browser, multi_agent, plugins, shell_snapshot, shell_tool, tool_search, unified_exec, workspace_dependencies.
- Current plugin/MCP surface includes computer-use and node_repl entries; redact environment values in human reports.

## Professional defaults

- Planning/research: `codex exec --ignore-rules --ephemeral -C <repo> -s read-only - <task.md>`
- Implementation: `codex exec --ignore-rules --ephemeral -C <repo> -s workspace-write -o <out> - <task.md>`
- Multi-root skill edits: add `--add-dir <additional-root>` explicitly.
- Review: prefer `codex review --uncommitted` from inside target repo, or `codex exec review` if more consistent with installed CLI behavior.

## UI skill integration

For frontend/UI tasks, use `/Users/shift/.codex/skills/ui-ux-pro-max/SKILL.md` and its local `scripts/search.py` before implementation. Persist design systems into the target project and make Codex cite the generated design-system paths in final output.
