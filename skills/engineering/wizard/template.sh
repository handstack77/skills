#!/usr/bin/env bash
#
# 마법사는 사람에게 수동 절차를 단계별로 안내합니다.
# /wizard 스킬이 생성했습니다.
#
# "STAGES" 표식 위의 모든 것은 마법사 라이브러리입니다. 손으로 고치지 마세요.
# 단계별 스테이지는 표식 아래에 작성하세요.

set -euo pipefail

# ──────────────────────────────────────────────────────────────────────────
# 마법사 라이브러리: 멋지고 일관된 UX이며 모든 마법사에서 동일합니다.
# ──────────────────────────────────────────────────────────────────────────

if [[ -t 1 ]] && command -v tput >/dev/null 2>&1 && [[ "$(tput colors 2>/dev/null || echo 0)" -ge 8 ]]; then
  BOLD=$(tput bold); DIM=$(tput dim); RESET=$(tput sgr0)
  BLUE=$(tput setaf 4); GREEN=$(tput setaf 2); YELLOW=$(tput setaf 3)
else
  BOLD=""; DIM=""; RESET=""; BLUE=""; GREEN=""; YELLOW=""
fi

# 작성자가 스테이지 섹션 맨 위에서 설정합니다.
TOTAL_STAGES=0

_STAGE_INDEX=0
ENV_FILE="${ENV_FILE:-.env}"
WRITTEN_ENV=()    # 이번 실행에서 ENV_FILE에 쓴 KEY
WRITTEN_SECRET=() # 이번 실행에서 설정한 시크릿 NAME
SKIPPED=()        # 하지 못한 것 (예: gh 없음)

# _clear는 현재 단계만 화면에 남도록 터미널을 지웁니다. 출력이 터미널이 아니면
# 아무 일도 하지 않으므로, 파이프로 보낸 로그는 읽을 수 있게 유지됩니다.
_clear() {
  [[ -t 1 ]] || return 0
  if command -v tput >/dev/null 2>&1 && tput clear 2>/dev/null; then return 0; fi
  printf '\033[2J\033[3J\033[H'
}

# banner "Title"은 시작 화면을 보여 줍니다: 이 마법사가 하는 일.
banner() {
  _clear
  printf '\n%s%s  %s%s\n' "$BOLD" "$BLUE" "$1" "$RESET"
  printf '%s  %s단계%s\n\n' "$DIM" "$TOTAL_STAGES" "$RESET"
  printf '%s  브라우저는 직접 조작하세요. 이 마법사는 무엇을 할지 정확히 알려 주고,\n' "$DIM"
  printf '  복사해 온 값을 캡처합니다. 언제든 Ctrl-C로 멈췄다가 나중에 다시\n'
  printf '  실행해도 됩니다. 이미 저장한 값은 기억하고 있습니다.%s\n' "$RESET"
  pause "시작할 준비가 되셨나요?"
}

# stage "Name"은 화면을 지운 뒤 스테이지를 알리고 진행 상황을 보여 줍니다.
# 화면을 지우므로 현재 단계만 화면에 남습니다.
stage() {
  _clear
  _STAGE_INDEX=$((_STAGE_INDEX + 1))
  printf '\n%s%s▸ 단계 %s/%s · %s%s\n' \
    "$BOLD" "$BLUE" "$_STAGE_INDEX" "$TOTAL_STAGES" "$1" "$RESET"
}

# say "..."는 일반 지시 줄을 출력합니다.
say()  { printf '  %s\n' "$1"; }
# step "..."는 사람이 브라우저에서 수행하는 번호 매긴 듯한 동작입니다.
step() { printf '  %s•%s %s\n' "$BLUE" "$RESET" "$1"; }
note() { printf '  %s%s%s\n' "$DIM" "$1" "$RESET"; }
warn() { printf '  %s⚠ %s%s\n' "$YELLOW" "$1" "$RESET"; }

# open_url URL은 WSL을 포함한 크로스 플랫폼으로 사람의 브라우저에서 엽니다.
open_url() {
  local url="$1"
  printf '  %s↗ 여는 중%s %s\n' "$GREEN" "$RESET" "$url"
  { if   command -v wslview     >/dev/null 2>&1; then wslview "$url"
    elif command -v explorer.exe >/dev/null 2>&1; then explorer.exe "$url"
    elif command -v xdg-open    >/dev/null 2>&1; then xdg-open "$url"
    elif command -v open        >/dev/null 2>&1; then open "$url"
    else false; fi
  } >/dev/null 2>&1 || warn "브라우저를 열 수 없으니 직접 방문하세요: $url"
}

# pause "msg"는 사람이 수동 작업을 마쳤다고 확인할 때까지 기다립니다.
pause() {
  printf '  %s%s%s ' "$DIM" "${1:-계속하려면 Enter를 누르세요}" "$RESET"
  read -r _ || true
}

# confirm "question"은 y/N 게이트이며, yes면 성공을 반환합니다.
confirm() {
  local reply=""
  printf '  %s? %s [y/N] ' "$YELLOW" "$1"
  read -r reply || true
  [[ "$reply" =~ ^[Yy] ]]
}

# _existing KEY: ENV_FILE에 있는 KEY의 현재 값(있다면)이며, write_env가 쓴 홑따옴표나
# 일반 dotenv의 큰따옴표 값은 벗겨 냅니다.
_existing() {
  [[ -f "$ENV_FILE" ]] || return 1
  local line value sq="'\\''"; line=$(grep -E "^${1}=" "$ENV_FILE" | tail -n1) || return 1
  value="${line#*=}"
  if [[ "$value" == \'*\' ]]; then value="${value:1:${#value}-2}"; value="${value//"$sq"/\'}"
  elif [[ "$value" == \"*\" ]]; then
    value="${value:1:${#value}-2}"
    [[ "$value" == *[\\\$\"]* ]] && return 1   # 이스케이프, $ 또는 ": 안전하게 디코딩할 수 없으니 다시 묻는다
  fi
  printf '%s' "$value"
}

# ask KEY "Prompt"는 값을 읽어 $KEY에 넣습니다. 다시 실행할 때는 기존 .env 값을
# 기본값으로 제안합니다(Enter로 유지). 보이는 입력(비밀 아님)이며 Readline으로 편집합니다.
# 입력 없이 EOF를 만나면 실패합니다.
ask() {
  local key="$1" prompt="$2" current input s=$'\001' e=$'\002' p rc=0
  current=$(_existing "$key" || true)
  # Readline이 커서 위치를 잡으려면 색상 코드를 \001..\002로 감싸야 합니다.
  p="  $s$BOLD$e$prompt$s$RESET$e "
  [[ -n "$current" ]] && p+="$s$DIM$e[Enter로 현재 값 유지]$s$RESET$e "
  read -e -r -p "$p" input || rc=1
  if (( rc )) && [[ -z "$input" ]]; then return 1; fi
  [[ -z "$input" && -n "$current" ]] && input="$current"
  printf -v "$key" '%s' "$input"
}

# ask_secret KEY "Prompt"는 ask와 같지만 입력이 숨겨집니다.
ask_secret() {
  local key="$1" prompt="$2" current input rc=0
  current=$(_existing "$key" || true)
  if [[ -n "$current" ]]; then
    printf '  %s%s%s %s[Enter로 현재 값 유지]%s ' "$BOLD" "$prompt" "$RESET" "$DIM" "$RESET"
  else
    printf '  %s%s%s ' "$BOLD" "$prompt" "$RESET"
  fi
  read -rs input || rc=1
  printf '\n'
  if (( rc )) && [[ -z "$input" ]]; then return 1; fi
  [[ -z "$input" && -n "$current" ]] && input="$current"
  printf -v "$key" '%s' "$input"
}

# write_env KEY VALUE는 KEY='VALUE'를 ENV_FILE에 upsert하고(기존 줄을 대체) $KEY를
# 설정합니다. 멱등적입니다. ENV_FILE을 모드 0600으로 만들고, 심볼릭 링크를 통해 쓰며,
# 기존 파일의 모드는 유지합니다.
write_env() {
  local key="$1" value="$2" tmp sq="'\\''"
  [[ -e "$ENV_FILE" ]] || (umask 077 && : > "$ENV_FILE")
  tmp=$(mktemp)
  grep -vE "^${key}=" "$ENV_FILE" > "$tmp" || true
  printf "%s='%s'\n" "$key" "${value//\'/$sq}" >> "$tmp"
  cat "$tmp" > "$ENV_FILE"
  rm -f "$tmp"
  printf -v "$key" '%s' "$value"
  WRITTEN_ENV+=("$key")
  printf '  %s✓ 기록함%s %s → %s\n' "$GREEN" "$RESET" "$key" "$ENV_FILE"
}

# set_secret NAME VALUE는 gh로 GitHub Actions 저장소 시크릿을 설정합니다. gh를 쓸 수
# 없거나 인증되지 않았으면 경고하고(기록해 두고) 넘어갑니다.
set_secret() {
  local name="$1" value="$2"
  if command -v gh >/dev/null 2>&1 && gh auth status >/dev/null 2>&1; then
    if printf '%s' "$value" | gh secret set "$name" >/dev/null 2>&1; then
      WRITTEN_SECRET+=("$name")
      printf '  %s✓ 설정함%s GitHub 시크릿 %s\n' "$GREEN" "$RESET" "$name"
      return
    fi
  fi
  SKIPPED+=("GitHub 시크릿 $name (직접 설정하세요: gh secret set $name)")
  warn "GitHub 시크릿 $name을(를) 건너뜀: gh가 준비되지 않았으니 나중에 설정하세요"
}

# set_var NAME VALUE는 GitHub Actions 저장소 변수(비밀 아님)를 설정합니다.
set_var() {
  local name="$1" value="$2"
  if command -v gh >/dev/null 2>&1 && gh auth status >/dev/null 2>&1; then
    if gh variable set "$name" --body "$value" >/dev/null 2>&1; then
      printf '  %s✓ 설정함%s GitHub 변수 %s\n' "$GREEN" "$RESET" "$name"
      return
    fi
  fi
  SKIPPED+=("GitHub 변수 $name")
  warn "GitHub 변수 $name을(를) 건너뜀, gh가 준비되지 않았으니 나중에 설정하세요"
}

# finish는 화면을 지운 뒤 설정된 모든 것의 마무리 요약을 보여 줍니다.
finish() {
  _clear
  printf '\n%s%s  ✓ 설정 완료%s\n' "$BOLD" "$GREEN" "$RESET"
  (( ${#WRITTEN_ENV[@]} ))    && note "$ENV_FILE에 값 ${#WRITTEN_ENV[@]}개를 기록함: ${WRITTEN_ENV[*]}"
  (( ${#WRITTEN_SECRET[@]} )) && note "GitHub 시크릿 ${#WRITTEN_SECRET[@]}개를 설정함: ${WRITTEN_SECRET[*]}"
  if (( ${#SKIPPED[@]} )); then
    printf '\n'; warn "아직 직접 해야 할 일:"
    for s in "${SKIPPED[@]}"; do note "  - $s"; done
  fi
  printf '\n'
}

# ──────────────────────────────────────────────────────────────────────────
# STAGES: 이 섹션을 작성하세요. 사람이 밟는 단계마다 stage() 하나씩.
# 아래 예시를 교체하세요. TOTAL_STAGES는 작성한 스테이지 수와 맞추세요.
# 모든 스테이지는 run_wizard 안에 두고 마지막 줄은 그대로 두세요. 그러면 bash가
# 첫 프롬프트 전에 파일 전체를 파싱하므로, 실행 도중 편집해도 깨지지 않습니다.
# ──────────────────────────────────────────────────────────────────────────

run_wizard() {

TOTAL_STAGES=1

banner "Stripe setup"

# ── 예시 스테이지: 실제 단계로 교체하세요 ───────────────────────────
stage "Stripe: API keys"
say "Stripe 테스트 키를 가져와 로컬 개발과 CI용으로 저장합니다."
open_url "https://dashboard.stripe.com/test/apikeys"
step "API keys 페이지에서 Publishable key(pk_test_로 시작)를 복사하세요."
ask STRIPE_PUBLISHABLE_KEY "공개 키를 붙여넣으세요:"
step "Secret key 행에서 'Reveal test key'를 클릭한 뒤 복사하세요."
ask_secret STRIPE_SECRET_KEY "비밀 키를 붙여넣으세요:"
write_env STRIPE_PUBLISHABLE_KEY "$STRIPE_PUBLISHABLE_KEY"
write_env STRIPE_SECRET_KEY "$STRIPE_SECRET_KEY"
set_secret STRIPE_SECRET_KEY "$STRIPE_SECRET_KEY"   # CI에는 이것이 필요합니다
# ──────────────────────────────────────────────────────────────────────────

finish
}

run_wizard "$@"; exit
