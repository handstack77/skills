# 이슈 트래커: 로컬 마크다운

이 저장소의 이슈와 명세는 `.scratch/`의 마크다운 파일로 있습니다.

## 관례

- 기능당 디렉터리 하나: `.scratch/<feature-slug>/`
- 명세는 `.scratch/<feature-slug>/spec.md`
- 구현 이슈는 티켓당 파일 하나로 `.scratch/<feature-slug>/issues/<NN>-<slug>.md`에 두며, `01`부터 번호를 매기고 하나로 합친 티켓 파일은 절대 두지 않습니다
- 트리아지 상태는 각 이슈 파일 상단 근처의 `Status:` 줄로 기록합니다(역할 문자열은 `triage-labels.md` 참고)
- 댓글과 대화 이력은 파일 맨 아래 `## Comments` 제목 아래에 덧붙입니다

## 스킬이 "이슈 트래커에 게시"라고 말할 때

`.scratch/<feature-slug>/` 아래에 새 파일을 만드세요(디렉터리가 필요하면 만드세요).

## 스킬이 "관련 티켓을 가져오라"고 말할 때

참조된 경로의 파일을 읽으세요. 사용자가 보통 경로나 이슈 번호를 직접 전달합니다.

## 길 찾기 작업

`/wayfinder`가 사용합니다. **지도**는 티켓마다 **자식** 파일 하나를 가진 파일입니다.

- **지도**: `.scratch/<effort>/map.md` (Notes / Decisions-so-far / Fog 본문).
- **자식 티켓**: `.scratch/<effort>/issues/NN-<slug>.md`, `01`부터 번호를 매기고 본문에 질문을 둡니다. `Type:` 줄이 티켓 유형(`research`/`prototype`/`grilling`/`task`)을 기록하고, `Status:` 줄이 `claimed`/`resolved`를 기록합니다.
- **차단**: 상단 근처의 `Blocked by: NN, NN` 줄. 나열된 모든 파일이 `resolved`이면 티켓은 차단이 풀립니다.
- **프런티어**: `.scratch/<effort>/issues/`에서 열려 있고, 차단이 풀렸고, 선점되지 않은 파일을 훑습니다. 번호가 앞선 것이 이깁니다.
- **선점**: 작업 전에 `Status: claimed`로 설정하고 저장합니다.
- **해결**: `## Answer` 제목 아래에 답을 덧붙이고, `Status: resolved`로 설정한 다음, `map.md`의 지도 Decisions-so-far에 컨텍스트 포인터(요지 + 링크)를 추가합니다.
