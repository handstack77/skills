#!/bin/bash

INPUT=$(cat)
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command')

DANGEROUS_PATTERNS=(
  "git push"
  "git reset --hard"
  "git clean -fd"
  "git clean -f"
  "git branch -D"
  "git checkout \."
  "git restore \."
  "push --force"
  "reset --hard"
)

for pattern in "${DANGEROUS_PATTERNS[@]}"; do
  if echo "$COMMAND" | grep -qE "$pattern"; then
    echo "차단됨(BLOCKED): '$COMMAND'은(는) 위험한 패턴 '$pattern'과 일치합니다. 사용자가 이 작업을 하지 못하도록 막아 두었습니다." >&2
    exit 2
  fi
done

exit 0
