#!/usr/bin/env bash
set -euo pipefail

root=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
workflows=${WORKFLOWS_DIR:-"$root/.github/workflows"}
count=0
errors=0

while IFS= read -r file; do
  while IFS= read -r line; do
    reference=${line#*uses:}
    reference=${reference//[[:space:]]/}
    [ -n "$reference" ] || continue
    count=$((count + 1))
    case "$reference" in
      ./*)
        continue
        ;;
      docker://*)
        digest=${reference##*@sha256:}
        if [ "$digest" = "$reference" ] || [ "${#digest}" -ne 64 ] || ! printf '%s' "$digest" | grep -Eq '^[0-9a-f]{64}$'; then
          printf '%s: Docker action must use an immutable sha256 digest: %s\n' "$file" "$reference" >&2
          errors=1
        fi
        continue
        ;;
    esac
    action=${reference%@*}
    sha=${reference##*@}
    if [ "$action" = "$reference" ] || [ "${#sha}" -ne 40 ] || ! printf '%s' "$sha" | grep -Eq '^[0-9a-f]{40}$'; then
      printf '%s: external Action must use a full 40-character lowercase SHA: %s\n' "$file" "$reference" >&2
      errors=1
    fi
  done < <(grep -E '^[[:space:]]*(-[[:space:]]*)?uses:[[:space:]]*' "$file" || true)
done < <(find "$workflows" -type f \( -name '*.yml' -o -name '*.yaml' \) -print | sort)

if [ "$count" -eq 0 ]; then
  printf '%s\n' "No Action references found in .github/workflows." >&2
  exit 1
fi

if [ "$errors" -ne 0 ]; then
  exit 1
fi

printf 'Action references: OK (%s reference(s))\n' "$count"
