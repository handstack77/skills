#!/usr/bin/env bash
# 사람이 개입하는(human-in-the-loop) 재현 루프.
# 이 파일을 복사하고, 아래 단계를 수정한 뒤 실행하세요.
# 에이전트가 스크립트를 실행하고, 사용자는 터미널의 안내를 따릅니다.
#
# 사용법:
#   bash hitl-loop.template.sh
#
# 헬퍼 두 개:
#   step "<지시>"                 → 지시를 보여 주고 Enter를 기다림
#   capture VAR "<질문>"          → 질문을 보여 주고 응답을 VAR에 읽어 들임
#
# 마지막에 캡처한 값을 KEY=VALUE로 출력해서 에이전트가 파싱합니다.
#
# `capture`는 값을 터미널에 다시 출력하고 에이전트가 그것을 읽으므로,
# 관찰한 내용을 캡처하고, 로그인은 `step`으로 사용자에게 맡기세요.

set -euo pipefail

step() {
  printf '\n>>> %s\n' "$1"
  read -r -p "    [Enter when done] " _
}

capture() {
  local var="$1" question="$2" answer
  printf '\n>>> %s\n' "$question"
  read -r -p "    > " answer
  printf -v "$var" '%s' "$answer"
}

# --- 아래를 수정 ---------------------------------------------------------

step "Open the app at http://localhost:3000 and sign in."

capture ERRORED "Click the 'Export' button. Did it throw an error? (y/n)"

capture ERROR_MSG "Paste the error message (or 'none'):"

# --- 위를 수정 ---------------------------------------------------------

printf '\n--- Captured ---\n'
printf 'ERRORED=%s\n' "$ERRORED"
printf 'ERROR_MSG=%s\n' "$ERROR_MSG"
