#!/usr/bin/env bash
set -euo pipefail

root=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
sha=0123456789abcdef0123456789abcdef01234567

cat >"$tmp/valid.json" <<EOF
{"schema":"ecommerce-ai-review/v1","head_sha":"$sha","scope":"artifact","verdict":"CHANGES_REQUIRED","summary":"A boundary is missing.","findings":[{"path":"docs/example.md","line":7,"message":"The boundary is absent.","impact":"Later work could widen scope.","minimal_fix":"State the excluded work."}]}
EOF
"$root/scripts/validate-ai-review.sh" "$tmp/valid.json" "$sha"

cat >"$tmp/invalid.json" <<EOF
{"schema":"ecommerce-ai-review/v1","head_sha":"$sha","scope":"artifact","verdict":"PASS","summary":"Looks good.","findings":[{"path":"docs/example.md","line":7,"message":"Unexpected finding.","impact":"Contradictory result.","minimal_fix":"Use a non-PASS verdict."}]}
EOF
if "$root/scripts/validate-ai-review.sh" "$tmp/invalid.json" "$sha"; then
  printf '%s\n' 'Validator accepted an invalid PASS report.' >&2
  exit 1
fi

printf '%s\n' 'AI review report validator tests: OK'
