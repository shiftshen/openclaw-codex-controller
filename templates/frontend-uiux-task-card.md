# Frontend/UIUX Codex Task Card

## Goal

Implement exactly one user-visible frontend/UI objective.

## Non-goals

- No unrelated refactors.
- No backend/API changes unless explicitly listed in allowed scope.
- No new dependencies unless justified and approved in the task card.
- No emojis as structural icons; use vector icon libraries/assets.

## Repo / branch

- Repo: `<absolute path>`
- Branch: `<current branch>`

## Allowed scope

- `<files/directories Codex may edit>`

## Required UI/UX Pro Max lane

Before writing UI code, Codex must run/read:

```bash
sed -n '1,220p' /Users/shift/.codex/skills/ui-ux-pro-max/SKILL.md
python3 /Users/shift/.codex/skills/ui-ux-pro-max/scripts/search.py   "<product industry audience style density>"   --design-system --persist   -p "<Project Name>"   --page "<page-or-feature-name>"   -f markdown
sed -n '1,240p' design-system/<project-slug>/MASTER.md
sed -n '1,240p' design-system/<project-slug>/pages/<page-or-feature-name>.md 2>/dev/null || true
```

Codex must implement from these design-system rules, not from generic taste.

## Implementation requirements

- Design tokens: colors, typography, spacing, radius/elevation.
- Layout: responsive breakpoints and content density.
- States: hover, focus, pressed, disabled, loading, empty, error.
- Accessibility: contrast, labels, keyboard/focus, reduced motion.
- Icons/assets: consistent vector icon family; no emoji UI controls.
- Anti-patterns: list what the design system says to avoid and avoid them.

## Verification gate

Run at least:

```bash
<project build/test command>
<lint/typecheck command if available>
<browser/runtime check command or screenshot path if applicable>
```

## Required Codex output

Return:

- generated/read design-system paths
- changed files
- implementation summary tied to design-system decisions
- exact verification commands + exit codes + key output
- browser/screenshot evidence if applicable
- blockers/risks
