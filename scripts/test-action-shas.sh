#!/usr/bin/env bash
set -euo pipefail

root=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

cp "$root/scripts/fixtures/action-shas/valid.yml" "$tmp/valid.yml"
output=$(WORKFLOWS_DIR="$tmp" "$root/scripts/check-action-shas.sh")
test "$output" = 'Action references: OK (4 reference(s))'

cp "$root/scripts/fixtures/action-shas/invalid.yml" "$tmp/invalid.yml"
if WORKFLOWS_DIR="$tmp" "$root/scripts/check-action-shas.sh" >/dev/null 2>&1; then
  printf '%s\n' 'Action SHA checker accepted unpinned external or Docker actions.' >&2
  exit 1
fi

actual_count=$(grep -RE '^[[:space:]]*(-[[:space:]]*)?uses:[[:space:]]*' "$root/.github/workflows" | wc -l | tr -d '[:space:]')
test "$actual_count" = 4
repo_output=$($root/scripts/check-action-shas.sh)
test "$repo_output" = "Action references: OK (${actual_count} reference(s))"

printf '%s\n' 'Action SHA checker tests: OK (named, local, Docker, and repository references)'
