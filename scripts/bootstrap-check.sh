#!/usr/bin/env bash
set -euo pipefail

root=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
cd "$root"

ruby ./scripts/check-yaml.rb
ruby ./scripts/check-template-boundaries.rb
./scripts/check-action-shas.sh
./scripts/test-action-shas.sh
./scripts/test-ai-review-validator.sh

if grep -RInE '[[:blank:]]+$' \
  --exclude-dir=.git \
  --exclude='*.min.*' \
  .; then
  printf '%s\n' 'Trailing whitespace found.' >&2
  exit 1
fi

printf '%s\n' 'Bootstrap repository checks: OK'
