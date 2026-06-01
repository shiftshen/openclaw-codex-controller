# Codex Verification Gates

Use these gates before accepting any Codex completion.

## Minimum universal gate

```bash
git status --short --branch
git diff --stat
git diff -- <relevant files>
```

## Code gates

- TypeScript/Node: `npm run build`, `npm test`, `npm run lint` if available.
- Python: `python -m pytest`, targeted script dry-run, syntax/import check.
- Shell/ops: `bash -n`, dry-run mode, read-only status command.
- Config: parser/validator plus the tool's own smoke test.

## UI/user-visible gates

- Build/typecheck.
- Browser/app runtime check.
- Screenshot or visual capture for layout-affecting work.
- Responsive checks for small and wide viewports.
- Accessibility/focus/contrast check when relevant.
- Compare implementation against generated `design-system/.../MASTER.md` and page override.

## Verdict rules

- `done`: all required gates passed and scope is clean.
- `partial`: useful code exists but verification is incomplete or some acceptance criteria remain.
- `blocked`: real missing access/environment/runtime blocker prevents progress.
