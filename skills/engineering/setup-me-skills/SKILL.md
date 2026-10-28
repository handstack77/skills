---
name: setup-me-skills
description: "이 저장소를 엔지니어링 스킬용으로 설정합니다. 이슈 트래커, 트리아지 라벨 어휘, 도메인 문서 레이아웃을 구성합니다. 다른 엔지니어링 스킬을 처음 쓰기 전에 한 번 실행하세요."
disable-model-invocation: true
---

# junchul 스킬 설정

엔지니어링 스킬이 전제하는 저장소별 설정을 구성하세요.

- **이슈 트래커**: 이슈가 있는 곳 (기본은 GitHub이며, 로컬 마크다운도 바로 지원)
- **트리아지 라벨**: 다섯 가지 표준 트리아지 역할에 쓰는 문자열
- **도메인 문서**: `GLOSSARY.md`와 ADR이 있는 곳, 그리고 그것을 읽는 소비자 규칙

이것은 결정적인 스크립트가 아니라 프롬프트 주도 스킬입니다. 탐색하고, 찾은 것을 제시하고, 사용자와 확인한 뒤, 쓰세요.

## 절차

### 1. 탐색

현재 저장소를 살펴서 시작 상태를 파악하세요. 있는 것은 읽고, 가정하지 마세요.

- `git remote -v`와 `.git/config`: GitHub 저장소인가요? 어느 것인가요?
- 저장소 루트의 `AGENTS.md`와 `CLAUDE.md`: 둘 중 있는 것이 있나요? 어느 쪽에든 이미 `## Agent skills` 섹션이 있나요?
- 저장소 루트의 `GLOSSARY.md`와 `GLOSSARY-MAP.md`
- `docs/adr/`와 `src/*/docs/adr/` 디렉터리들
- `docs/agents/`: 이 스킬의 이전 출력이 이미 있나요?
- `.scratch/`: 로컬 마크다운 이슈 트래커 관례가 이미 쓰이고 있다는 신호
- `triage` 스킬이 설치되어 있나요? (이 스킬 옆에 `triage` 스킬 폴더가 있거나, 사용 가능한 스킬에 `triage`가 있음.) 이것이 B 섹션을 아예 실행할지를 결정합니다.
- 모노레포 신호: `pnpm-workspace.yaml`, `package.json`의 `workspaces` 필드, 또는 자체 `src/`가 있는 채워진 `packages/*`. 이것들은 정말로 큰 다중 패키지 저장소에만 있습니다. 없다면 단일 컨텍스트이며, 거의 모든 저장소가 그렇습니다.

### 2. 발견한 것을 제시하고 묻기

있는 것과 없는 것을 요약하세요. 그다음 섹션을 순서대로 진행하세요. 섹션 하나에 답 하나, 그다음 다음 섹션입니다.

각 섹션은 추천 답으로 시작해서 사용자가 한마디로 수락할 수 있게 하세요. 선택이 정말로 갈릴 때만 한 줄 설명을 주고, 탐색이 이미 정리한 섹션은 아예 건너뛰세요(`triage`가 설치되지 않았다면 B 섹션, 모노레포가 아니라면 C 섹션).

**A 섹션: 이슈 트래커.**

> 설명: "이슈 트래커"는 이 저장소의 이슈가 있는 곳입니다. `to-tickets`, `triage`, `to-spec` 같은 스킬이 여기서 읽고 여기에 씁니다. `gh issue create`를 호출할지, `.scratch/` 아래에 마크다운 파일을 쓸지, 당신이 설명하는 다른 워크플로를 따를지 알아야 합니다. 이 저장소의 작업을 실제로 추적하는 곳을 고르세요.

기본 자세: 이 스킬들은 GitHub용으로 설계되었습니다. `git remote`가 GitHub를 가리키면 그것을 제안하세요. `git remote`가 GitLab(`gitlab.com` 또는 자체 호스팅)을 가리키면 GitLab을 제안하세요. 그 외의 경우(또는 사용자가 원하면) 다음을 제시하세요.

- **GitHub**: 이슈는 저장소의 GitHub Issues에 있음 (`gh` CLI 사용)
- **GitLab**: 이슈는 저장소의 GitLab Issues에 있음 ([`glab`](https://gitlab.com/gitlab-org/cli) CLI 사용)
- **로컬 마크다운**: 이슈는 이 저장소의 `.scratch/<feature>/` 아래 파일로 있음 (혼자 하는 프로젝트나 원격이 없는 저장소에 좋음)
- **기타** (Jira, Linear 등): 사용자에게 워크플로를 한 문단으로 설명해 달라고 요청하세요. 스킬이 자유 서술로 기록합니다

선택을 `docs/agents/issue-tracker.md`에 기록하세요. GitHub와 GitLab 템플릿에는 "요청 접점으로서의 PR" 플래그가 있고 기본값은 **꺼짐**입니다. 꺼 둔 채로 두고 꺼내지 마세요. 외부 PR을 트리아지 큐에 넣고 싶은 사용자는 나중에 파일에서 플래그를 바꿀 수 있습니다.

**B 섹션: 트리아지 라벨 어휘.** `triage` 스킬이 설치되어 있지 않다면(탐색에서 알게 됨) 이 섹션을 아예 건너뛰세요. 설치되지 않은 스킬은 라벨이 필요 없기 때문입니다.

설치되어 있다면 질문은 정확히 하나만 하세요.

> 기본 트리아지 라벨을 유지하시겠어요? (추천: **예**)

기본값은 다섯 가지 표준 역할이며, 각 라벨 문자열은 자기 이름과 같습니다. `needs-triage`, `needs-info`, `ready-for-agent`, `ready-for-human`, `wontfix`. **예**라면 그대로 쓰세요. 사용자가 아니오라고 할 때만(대개 트래커가 이미 다른 이름을 쓰기 때문입니다. 예: `needs-triage` 대신 `bug:triage`), 재정의를 수집해서 `triage`가 중복을 만들지 않고 기존 라벨을 적용하게 하세요.

**C 섹션: 도메인 문서.** 기본은 **단일 컨텍스트**(저장소 루트의 `GLOSSARY.md` 하나 + `docs/adr/`)입니다. 거의 모든 저장소에 맞으니 묻지 않고 쓰세요.

탐색이 모노레포 신호를 찾았을 때만 **다중 컨텍스트**(컨텍스트별 `GLOSSARY.md` 파일을 가리키는 루트 `GLOSSARY-MAP.md`)를 제시하세요. 그다음 어느 레이아웃을 원하는지 확인하세요.

### 3. 확인하고 편집

사용자에게 다음의 초안을 보여 주세요.

- 현재 CLI의 프로젝트 지침 파일에 추가할 `## Agent skills` 블록 (선택 규칙은 4단계 참고)
- `docs/agents/issue-tracker.md`, `docs/agents/domain.md`, `docs/agents/triage-labels.md`의 내용 (마지막 것은 `triage`가 설치되었을 때만)

쓰기 전에 사용자가 편집하게 하세요.

### 4. 쓰기

**편집할 파일 고르기:**

- Claude Code에서는 `CLAUDE.md`를 편집하거나 만듭니다.
- Codex CLI에서는 `AGENTS.md`를 편집하거나 만듭니다.
- 두 CLI를 함께 쓰는 프로젝트에서는 두 파일이 같은 `docs/agents/*.md`를 가리키도록 유지합니다. 공통 설정 본문은 그 문서들에 두고 지침 파일에는 짧은 포인터만 둡니다.
- 현재 CLI를 식별할 수 없을 때만 사용자에게 어느 지침 파일을 쓸지 물으세요.

선택한 파일에 `## Agent skills` 블록이 이미 있다면 중복을 덧붙이지 말고 그 내용을 제자리에서 갱신하세요. 주변 섹션에 대한 사용자의 편집을 덮어쓰지 마세요.

블록:

```markdown
## Agent skills

### Issue tracker

[이슈를 추적하는 곳의 한 줄 요약]. `docs/agents/issue-tracker.md` 참고.

### Triage labels

[라벨 어휘의 한 줄 요약]. `docs/agents/triage-labels.md` 참고.

### Domain docs

[레이아웃의 한 줄 요약: "single-context" 또는 "multi-context"]. `docs/agents/domain.md` 참고.
```

`### Triage labels` 하위 블록을 포함하고 `docs/agents/triage-labels.md`를 쓰는 것은 `triage`가 설치되어 B 섹션이 실행되었을 때만입니다. 그렇지 않으면 둘 다 생략합니다.

B 섹션이 GitHub나 GitLab에서 실행되었다면, 트래커에 없는 설정된 각 라벨을 만드세요(`gh label create` / `glab label create`).

그다음 이 스킬 폴더의 시드 템플릿을 시작점으로 문서 파일을 쓰세요.

- [issue-tracker-github.md](./issue-tracker-github.md): GitHub 이슈 트래커
- [issue-tracker-gitlab.md](./issue-tracker-gitlab.md): GitLab 이슈 트래커
- [issue-tracker-local.md](./issue-tracker-local.md): 로컬 마크다운 이슈 트래커
- [triage-labels.md](./triage-labels.md): 라벨 매핑 (`triage`가 설치된 경우만)
- [domain.md](./domain.md): 도메인 문서 소비자 규칙 + 레이아웃

"기타" 이슈 트래커라면 사용자의 설명으로 `docs/agents/issue-tracker.md`를 처음부터 쓰세요.

### 5. 완료

사용자에게 설정이 끝났다고 알리고, 이제 어떤 엔지니어링 스킬이 이 파일들에서 읽을지 알려 주세요. 나중에 `docs/agents/*.md`를 직접 편집해도 된다고 언급하세요. 이 스킬을 다시 실행해야 하는 것은 이슈 트래커를 바꾸거나 처음부터 다시 시작하고 싶을 때뿐입니다.
