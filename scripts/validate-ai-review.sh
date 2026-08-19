#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -ne 2 ]; then
  printf 'Usage: %s REPORT_JSON EXPECTED_HEAD_SHA\n' "$0" >&2
  exit 64
fi

report=$1
head_sha=$2

jq -e --arg sha "$head_sha" '
  type == "object" and
  .schema == "ecommerce-ai-review/v1" and
  .head_sha == $sha and
  (.scope | IN("artifact", "slice")) and
  (.verdict | IN("PASS", "CHANGES_REQUIRED", "ESCALATE", "FAIL_CLOSED")) and
  (.summary | type == "string" and length > 0 and length <= 1500) and
  (.findings | type == "array" and length <= 20) and
  all(.findings[];
    type == "object" and
    (.path | type == "string" and length > 0 and length <= 400) and
    (.line | type == "number" and . >= 1 and floor == .) and
    (.message | type == "string" and length > 0 and length <= 2000) and
    (.impact | type == "string" and length > 0 and length <= 1000) and
    (.minimal_fix | type == "string" and length > 0 and length <= 1000)
  ) and
  (if .verdict == "PASS" then (.findings | length == 0)
   elif .verdict == "CHANGES_REQUIRED" then (.findings | length > 0)
   else true
   end)
' "$report" >/dev/null
