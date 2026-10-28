# 이슈 트래커: GitHub

이 저장소의 이슈와 명세는 GitHub 이슈로 있습니다. 모든 작업에 `gh` CLI를 사용하세요.

## 관례

- **이슈 만들기**: `gh issue create --title "..." --body "..."`. 여러 줄 본문에는 heredoc을 쓰세요.
- **이슈 읽기**: `gh issue view <number> --json number,title,body,labels,comments`.
- **이슈 나열**: `gh issue list --state open --json number,title,body,labels,comments --jq '[.[] | {number, title, body, labels: [.labels[].name], comments: [.comments[].body]}]'`에 적절한 `--label`과 `--state` 필터를 더하세요.
- **이슈를 부모의 하위 이슈로 만들기**: `gh issue create --parent <parent> ...`, 또는 나중에 `gh issue edit <parent> --add-sub-issue <child>` (`gh` 2.94+). 더 오래된 `gh`: `gh api --method POST repos/<owner>/<repo>/issues/<parent>/sub_issues -F sub_issue_id=<child-db-id>` (아래 **차단**과 같은 데이터베이스 id). 하위 이슈를 쓰지 않으면 자식 본문 맨 위에 `Part of #<parent>`를 넣으세요.
- **이슈에 댓글 달기**: `gh issue comment <number> --body "..."`
- **라벨 적용 / 제거**: `gh issue edit <number> --add-label "..."` / `--remove-label "..."`
- **닫기**: `gh issue close <number> --comment "..."`

저장소는 `git remote -v`에서 추론합니다. 클론 안에서 실행하면 `gh`가 자동으로 합니다.

## 트리아지 접점으로서의 풀 리퀘스트

**요청 접점으로서의 PR: 아니오.** _(이 저장소가 외부 PR을 기능 요청으로 취급하면 `yes`로 설정하세요. `/triage`가 이 플래그를 읽습니다.)_

`yes`로 설정하면 PR은 `gh pr` 대응 명령을 사용해 이슈와 같은 라벨과 상태를 거칩니다.

- **PR 읽기**: `gh pr view <number> --comments`, diff는 `gh pr diff <number>`.
- **트리아지할 외부 PR 나열**: `gh api --paginate 'repos/{owner}/{repo}/pulls?state=open' --jq '.[] | select(.author_association | IN("OWNER","MEMBER","COLLABORATOR") | not) | {number, title, author: .user.login, author_association, labels: [.labels[].name]}'`.
- **댓글 / 라벨 / 닫기**: `gh pr comment`, `gh pr edit --add-label`/`--remove-label`, `gh pr close`.

GitHub는 이슈와 PR이 하나의 번호 공간을 공유하므로 단순한 `#42`는 둘 중 어느 것일 수도 있습니다. `gh pr view 42`로 해석하고 안 되면 `gh issue view 42`로 되돌아가세요.

## 스킬이 "이슈 트래커에 게시"라고 말할 때

GitHub 이슈를 만드세요.

## 스킬이 "관련 티켓을 가져오라"고 말할 때

위의 **이슈 읽기**처럼 읽으세요.

## 길 찾기 작업

`/wayfinder`가 사용합니다. **지도**는 티켓인 **자식** 이슈들을 가진 이슈 하나입니다.

- **지도**: `wayfinder:map` 라벨이 붙은 이슈 하나로, Notes / Decisions-so-far / Fog 본문을 담습니다. `gh issue create --label wayfinder:map`.
- **자식 티켓**: GitHub 하위 이슈로 지도에 연결된 이슈입니다(**이슈를 부모의 하위 이슈로 만들기** 참고). 하위 이슈가 활성화되어 있지 않다면 자식을 지도 본문의 작업 목록에 추가하고 자식 본문 맨 위에 `Part of #<map>`을 넣으세요. 라벨: `wayfinder:<type>` (`research`/`prototype`/`grilling`/`task`). 선점되면 티켓은 이를 진행하는 개발자에게 할당됩니다.
- **차단**: GitHub의 **네이티브 이슈 의존성**이며 표준적이고 UI에서 보이는 표현입니다. `gh api --method POST repos/<owner>/<repo>/issues/<child>/dependencies/blocked_by -F issue_id=<blocker-db-id>`로 관계를 추가하세요. `<blocker-db-id>`는 차단하는 쪽의 숫자 **데이터베이스 id**입니다(`gh api repos/<owner>/<repo>/issues/<n> --jq .id`. `#number`나 `node_id`가 _아닙니다_). GitHub는 `issue_dependencies_summary.blocked_by`(열린 차단자만, 실제 게이트)를 보고합니다. 의존성을 쓸 수 없다면 자식 본문 맨 위에 `Blocked by: #<n>, #<n>` 줄로 되돌아가세요. 모든 차단자가 닫히면 티켓은 차단이 풀립니다.
- **프런티어 쿼리**: 지도의 열린 자식(`gh issue list --state open`, 지도의 하위 이슈 / 작업 목록으로 범위 한정)을 나열하고, 열린 차단자가 있거나(`issue_dependencies_summary.blocked_by > 0`, 또는 `Blocked by` 줄에 열린 이슈) 담당자가 있는 것은 제외합니다. 지도 순서상 첫 번째가 이깁니다.
- **선점**: `gh issue edit <n> --add-assignee @me`, 세션의 첫 쓰기입니다.
- **해결**: `gh issue comment <n> --body "<answer>"`, 그다음 `gh issue close <n>`, 그다음 지도의 Decisions-so-far에 컨텍스트 포인터(요지 + 링크)를 추가합니다.
