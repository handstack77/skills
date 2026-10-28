#!/usr/bin/env bash
set -euo pipefail

# 참고: 이것은 개발 전용 스크립트이며 이 저장소의 메인테이너가 쓰도록 만든 것입니다.
# 지원되는 설치 프로그램이 아닙니다. 이 스크립트의 수정이나 수정 요청은
# 승인되지 않습니다.
#
# 저장소의 모든 스킬을 각 에이전트 하니스가 쓰는 로컬 스킬 디렉터리에 연결합니다.
#   - ~/.claude/skills: Claude Code
#   - ~/.agents/skills: Codex 및 그 밖의 Agent Skills 호환 하니스
# 각 항목은 이 저장소로 향하는 심볼릭 링크이므로, 설치된 스킬을 최신으로
# 유지하려면 `git pull`만 하면 됩니다.

REPO="$(cd "$(dirname "$0")/.." && pwd)"
DESTS=("$HOME/.claude/skills" "$HOME/.agents/skills")

# 저장소의 스킬을 한 번 수집한 뒤 모든 대상에 연결합니다. `deprecated/`는
# 퇴역했고, `misc/`는 갖고는 있지만 거의 쓰지 않으며 홍보하지 않습니다(각 버킷의
# README 참고). 둘 다 매일 쓰는 스킬 디렉터리에 속하지 않으므로, 홍보하지 않는
# 스킬을 다른 곳에서 제외하는 것과 마찬가지로 여기서도 건너뜁니다.
# `in-progress/`는 여전히 연결합니다. 일부러 공개했고 피드백을 구하는 것이며,
# 이 로컬 설치가 바로 그 피드백 루프가 도는 곳이기 때문입니다.
names=()
srcs=()
while IFS= read -r -d '' skill_md; do
  src="$(dirname "$skill_md")"
  names+=("$(basename "$src")")
  srcs+=("$src")
done < <(find "$REPO/skills" -name SKILL.md -not -path '*/node_modules/*' -not -path '*/deprecated/*' -not -path '*/misc/*' -print0)

for DEST in "${DESTS[@]}"; do
  # $DEST가 이 저장소로 해석되는 심볼릭 링크라면, 스킬별 심볼릭 링크를 저장소
  # 자신의 skills/ 트리 안에 다시 쓰게 됩니다. 작업 사본을 오염시키지 않도록
  # 감지해서 중단합니다.
  if [ -L "$DEST" ]; then
    resolved="$(readlink -f "$DEST")"
    case "$resolved" in
      "$REPO"|"$REPO"/*)
        echo "오류: $DEST은(는) 이 저장소($resolved)로 향하는 심볼릭 링크입니다." >&2
        echo "제거(rm \"$DEST\")한 뒤 다시 실행하세요. 스크립트가 실제 디렉터리로 다시 만듭니다." >&2
        exit 1
        ;;
    esac
  fi

  mkdir -p "$DEST"

  for i in "${!names[@]}"; do
    name="${names[$i]}"
    src="${srcs[$i]}"
    target="$DEST/$name"

    if [ -e "$target" ] && [ ! -L "$target" ]; then
      rm -rf "$target"
    fi

    ln -sfn "$src" "$target"
    echo "연결함 $name -> $src ($DEST)"
  done
done
