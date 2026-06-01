#!/usr/bin/env bash
set -euo pipefail

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"

if [[ -z "${OPENCLAW_WORKSPACE:-}" ]]; then
  echo "ERROR: OPENCLAW_WORKSPACE is required." >&2
  echo "Usage: OPENCLAW_WORKSPACE=/path/to/openclaw/workspace $0" >&2
  exit 2
fi

if [[ ! -d "$OPENCLAW_WORKSPACE" ]]; then
  echo "ERROR: OPENCLAW_WORKSPACE does not exist: $OPENCLAW_WORKSPACE" >&2
  exit 2
fi

if [[ ! -f "$BASE_DIR/SKILL.md" ]]; then
  echo "ERROR: missing SKILL.md in package root: $BASE_DIR" >&2
  exit 1
fi

if [[ ! -d "$BASE_DIR/templates" ]]; then
  echo "ERROR: missing templates/ in package root: $BASE_DIR" >&2
  exit 1
fi

if [[ ! -f "$BASE_DIR/scripts/progress_report.py" ]]; then
  echo "ERROR: missing scripts/progress_report.py in package root: $BASE_DIR" >&2
  exit 1
fi

TARGET_DIR="$OPENCLAW_WORKSPACE/skills/codex-controller"

mkdir -p "$TARGET_DIR"
install -m 0644 "$BASE_DIR/SKILL.md" "$TARGET_DIR/SKILL.md"

rm -rf "$TARGET_DIR/templates"
mkdir -p "$TARGET_DIR/templates"
find "$BASE_DIR/templates" -type f -maxdepth 1 -print0 | while IFS= read -r -d '' file; do
  install -m 0644 "$file" "$TARGET_DIR/templates/$(basename "$file")"
done

rm -rf "$TARGET_DIR/scripts"
mkdir -p "$TARGET_DIR/scripts"
install -m 0755 "$BASE_DIR/scripts/progress_report.py" "$TARGET_DIR/scripts/progress_report.py"

echo "Installed codex-controller skill to: $TARGET_DIR"
