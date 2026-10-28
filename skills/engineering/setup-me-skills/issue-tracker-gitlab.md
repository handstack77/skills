# 이슈 트래커: GitLab

이 저장소의 이슈와 명세는 GitLab 이슈로 있습니다. 모든 작업에 [`glab`](https://gitlab.com/gitlab-org/cli) CLI를 사용하세요.

## 관례

- **이슈 만들기**: `glab issue create --title "..." --description "..."`. 여러 줄 설명에는 heredoc을 쓰세요. 편집기를 열려면 `--description -`을 전달하세요.
- **이슈 읽기**: `glab issue view <number> --comments`. 기계가 읽을 수 있는 출력은 `-F json`을 쓰세요.
- **이슈 나열**: `glab issue list -O json`에 적절한 `--label` 필터를 더하세요.
- **이슈에 댓글 달기**: `glab issue note <number> --message "..."`. GitLab은 댓글을 "노트"라고 부릅니다.
- **라벨 적용 / 제거**: `glab issue update <number> --label "..."` / `--unlabel "..."`. 여러 라벨은 쉼표로 구분하거나 플래그를 반복해서 줄 수 있습니다.
- **닫기**: `glab issue close <number>`. `glab issue close`는 닫는 댓글을 받지 않으므로, 먼저 `glab issue note <number> --message "..."`로 설명을 게시한 다음 닫으세요.
- **머지 리퀘스트**: GitLab은 PR을 "머지 리퀘스트"라고 부릅니다. `glab mr create`, `glab mr view`, `glab mr note` 등을 쓰세요. `gh pr ...`과 같은 형태이며 `pr` 대신 `mr`, `comment`/`--body` 대신 `note`/`--message`를 씁니다.

저장소는 `git remote -v`에서 추론합니다. 클론 안에서 실행하면 `glab`이 자동으로 합니다.

## 트리아지 접점으로서의 머지 리퀘스트

**요청 접점으로서의 MR: 아니오.** _(이 저장소가 외부 머지 리퀘스트를 기능 요청으로 취급하면 `yes`로 설정하세요. `/triage`가 이 플래그를 읽습니다.)_

`yes`로 설정하면 MR은 `glab mr` 대응 명령을 사용해 이슈와 같은 라벨과 상태를 거칩니다.

- **MR 읽기**: `glab mr view <number> --comments`, diff는 `glab mr diff <number>`.
- **트리아지할 외부 MR 나열**: `glab mr list -F json`, 그다음 작성자가 프로젝트 멤버/소유자가 아닌 MR만 남깁니다(메인테이너의 진행 중인 작업이 아니라 기여자의 MR).
- **댓글 / 라벨 / 닫기**: `glab mr note`, `glab mr update --label`/`--unlabel`, `glab mr close`.

GitHub와 달리 GitLab은 이슈와 MR의 번호를 따로 매기므로, 메인테이너가 어느 접점을 뜻하는지 알면 `#42`는 모호하지 않습니다.

## 스킬이 "이슈 트래커에 게시"라고 말할 때

GitLab 이슈를 만드세요.

## 스킬이 "관련 티켓을 가져오라"고 말할 때

`glab issue view <number> --comments`를 실행하세요.

## 길 찾기 작업

`/wayfinder`가 사용합니다. **지도**는 티켓인 **자식** 이슈들을 가진 이슈 하나입니다.

- **지도**: `wayfinder:map` 라벨이 붙은 이슈 하나로, Notes / Decisions-so-far / Fog 본문을 담습니다. `glab issue create --label wayfinder:map`. (네이티브 에픽이 있는 GitLab 등급에서는 에픽이 지도를 대신 담을 수 있습니다. 라벨이 붙은 이슈는 어디서나 동작합니다.)
- **자식 티켓**: 설명 맨 위에 `Part of #<map>`이 있고 `wayfinder:<type>` 라벨(`research`/`prototype`/`grilling`/`task`)이 붙은 이슈입니다. 선점되면 티켓은 이를 진행하는 개발자에게 할당됩니다.
- **차단**: GitLab의 **네이티브 차단 링크**이며 표준적이고 UI에서 보이는 표현입니다. `/blocked_by #<n>` 퀵 액션을 노트로 게시해서 추가하세요(`glab issue note <child> --message "/blocked_by #<blocker>"`). 네이티브 차단 링크는 Premium/Ultimate 기능입니다. 무료 등급(또는 쓸 수 없는 곳)에서는 설명 맨 위의 `Blocked by: #<n>, #<n>` 줄로 되돌아가세요. 모든 차단자가 닫히면 티켓은 차단이 풀립니다.
- **프런티어 쿼리**: 지도의 자식으로 범위를 한정한 `glab issue list -O json`에서 열린 차단자가 있는 것을 제외합니다. 열린 이슈로의 네이티브 `blocked_by` 링크(`glab api projects/:id/issues/<child-iid>/links`), `Blocked by` 줄의 열린 이슈, 또는 담당자가 있는 것입니다. 지도 순서상 첫 번째가 이깁니다.
- **선점**: `glab issue update <n> --assignee @me`, 세션의 첫 쓰기입니다.
- **해결**: `glab issue note <n> --message "<answer>"`, 그다음 `glab issue close <n>`, 그다음 지도의 Decisions-so-far에 컨텍스트 포인터(요지 + 링크)를 추가합니다.
