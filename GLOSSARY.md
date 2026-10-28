# handstack Skills

Claude Code가 로드하는 에이전트 스킬(슬래시 명령과 동작)의 모음입니다. 스킬은 버킷으로 정리되며, `/setup-me-skills`가 내보내는 저장소별 설정에 의해 소비됩니다.

## Language

**Issue tracker**:
저장소의 이슈를 호스팅하는 도구: GitHub Issues, Linear, 로컬 `.scratch/` 마크다운 관례 등. `to-tickets`, `to-spec`, `triage` 같은 스킬이 여기서 읽고 여기에 씁니다.
_Avoid_: backlog manager, backlog backend, issue host

**Issue**:
**Issue tracker** 안의 추적되는 단일 작업 단위: 버그, 과업, 명세, 또는 `to-tickets`가 만든 슬라이스.
_Avoid_: ticket (티켓이라고 부르는 외부 시스템을 인용할 때나 **Decision ticket**에만 사용, 아래 참고)

**Decision ticket**:
`wayfinder`의 단위: `wayfinder:map`의 자식 **Issue**이며, 해결이 곧 결정인 *질문*을 담고 실행할 빌드의 조각이 아닙니다. **decision**이라는 수식어가 구현 티켓과 구별해 줍니다. `wayfinder`가 이 용어를 도입한 뒤에는 "ticket"이라고 씁니다.

**Triage role**:
트리아지 중에 **Issue**에 적용되는 표준 상태 머신 라벨(예: `needs-triage`, `ready-for-afk`). 각 역할은 `docs/agents/triage-labels.md`를 통해 **Issue tracker**의 실제 라벨 문자열에 매핑됩니다.

## Relationships

- **Issue tracker**는 많은 **Issue**를 가진다
- **Issue**는 한 번에 하나의 **Triage role**을 가진다
- **Decision ticket**은 **Issue**이다 (`wayfinder:map`의 자식)

## Flagged ambiguities

- "backlog"는 이전에 이슈를 호스팅하는 *도구*와 그 안의 *작업 덩어리* 둘 다를 뜻하는 데 쓰였습니다. 해결됨: 도구는 **Issue tracker**이며, "backlog"는 더 이상 도메인 용어로 쓰이지 않습니다.
- "backlog backend" / "backlog manager". 해결됨: **Issue tracker**로 합쳐졌습니다.
