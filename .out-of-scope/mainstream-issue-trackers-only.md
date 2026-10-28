# 이슈 트래커 통합: GitHub, GitLab, 로컬 마크다운만

`setup-me-skills`는 정확히 세 가지 이슈 트래커를 일급으로 지원하며, `skills/engineering/setup-me-skills/`의 시드 템플릿마다 하나씩입니다.

- **GitHub** (`issue-tracker-github.md`, `gh` 사용)
- **GitLab** (`issue-tracker-gitlab.md`, `glab` 사용)
- **로컬 마크다운** (`issue-tracker-local.md`, `.scratch/` 아래 파일)

그 밖의 트래커에 대한 일급 백엔드를 추가해 달라는 요청은 범위 밖입니다. Jira, Linear, Azure DevOps, Trello, YouTrack, 그리고 새로운 에이전트 중심 트래커를 포함합니다.

## 범위 밖인 이유

모든 이슈 트래커 백엔드는 CLI의 형태(명령, 플래그, 출력 파싱)를 스킬에 하드코딩합니다. 새 백엔드마다 영구적인 유지보수 표면이 생깁니다. 도구의 CLI가 진화해도 계속 동작해야 하고, `/to-spec`, `/to-tickets`, `/triage` 등에 대해 계속 테스트되어야 하기 때문입니다. 저는 GitHub를 쓰므로 실제로 옳게 유지할 수 있는 백엔드는 그것입니다. GitLab은 형태가 충분히 가까워서 함께 갈 수 있고, 로컬 마크다운은 CLI가 전혀 필요 없습니다.

인기가 이것을 바꾸지는 않습니다. Jira는 널리 쓰이고 공식 CLI(`acli`)도 있지만 여전히 템플릿을 받지 못합니다. 제가 운영하지 않는 백엔드이고, 자체 링크 의미론, 워크플로 상태, CLI의 별난 점을 계속 테스트해야 합니다. 도구가 주류든 아니든 비용은 저에게 떨어집니다.

다른 모든 트래커는 `/setup-me-skills`의 **기타** 옵션을 거칩니다. 워크플로를 한 문단으로 설명하면 스킬이 그것을 `docs/agents/issue-tracker.md`에 산문으로 기록합니다. 그 파일은 당신 것입니다. 동작하는 Jira나 Linear 워크플로를 다듬었다면 자신의 저장소에 보관하거나 공개하고, 설정이 그것을 가리키게 하세요.

## 이전 요청

- #99: "Add dex as an issue tracker backend" (dex was ~3 months old and ~300 stars at the time of the request)
- #258: "Add Jira as first-class issue tracker via Rovo MCP"
- #1137: "Add Jira as a first-class issue tracker, via Atlassian's official CLI (`acli`)"
