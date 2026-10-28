스킬은 `skills/` 아래의 버킷 폴더로 정리됩니다.

- `engineering/`: 매일 하는 코드 작업
- `productivity/`: 매일 하는 코드 외 워크플로 도구
- `misc/`: 갖고는 있지만 거의 쓰지 않으며, 홍보하지 않음
- `in-progress/`: 베타. 기본 플러그인 설치 대상에서 제외
- `deprecated/`: 더 이상 쓰지 않음

`engineering/`과 `productivity/`는 Claude Code와 Codex CLI의 기본 플러그인 설치 대상입니다. 두 버킷의 모든 스킬은 최상위 `README.md`에서 해당 `SKILL.md`로 연결해야 합니다. `misc/`, `in-progress/`, `deprecated/`는 기본 플러그인 설치 대상과 최상위 카탈로그에서 제외합니다.

설정 방법은 [.agents/install-block.md](./.agents/install-block.md)를 따릅니다. 원본은 `.`입니다. 이 디렉토리를 로컬 마켓플레이스로 등록해 `handstack-skills@handstack` 플러그인을 설치합니다. 결정 근거는 [ADR 0002](./.agents/adr/0002-ship-as-a-claude-code-plugin.md)를 참고하세요.

최상위 `README.md`의 각 스킬 항목은 스킬 이름을 해당 `SKILL.md`에 링크해야 합니다.

각 버킷 폴더에는 버킷의 모든 스킬을 한 줄 설명과 함께 나열하는 `README.md`가 있으며, 스킬 이름은 해당 `SKILL.md`에 링크됩니다. 홍보하는 버킷의 `README.md`와 최상위 `README.md`는 항목을 **사용자 호출형**과 **모델 호출형**으로 묶습니다. 홍보하지 않는 버킷(`misc/`, `in-progress/`)의 `README.md`는 평평한 목록을 씁니다.

`engineering/`과 `productivity/`의 스킬에는 `docs/<bucket>/<skill-name>.md`에 사람이 읽는 문서 페이지도 있습니다(docs 트리는 `skills/` 아래의 그 두 버킷 폴더를 그대로 반영합니다). 문서 링크는 이 저장소를 기준으로 한 상대 경로를 사용합니다. `engineering/`이나 `productivity/`의 스킬을 추가하거나, 이름을 바꾸거나, 동작을 바꿀 때는 [.agents/writing-docs.md](./.agents/writing-docs.md)에 따라 문서 페이지를 만들거나 다시 동기화하세요. 완성된 페이지에는 네 개의 섹션이 있습니다. **하는 일**, **언제 쓰나**, **자주 묻는 질문**, **잘 작동하는 신호**입니다. `writing-docs.md`에 템플릿, 섹션 순서, 질문을 찾을 곳이 있습니다. 홍보하지 않는 버킷(`misc/`, `in-progress/`, `deprecated/`)의 스킬에는 문서 페이지가 **없습니다**. 유일한 예외는 홍보하는 스킬이 완전히 제거된 경우입니다. 그 페이지는 보관됨으로 표시된 채 남습니다(`writing-docs.md` 참고).

모든 `SKILL.md`는 사용자 호출형(`disable-model-invocation: true`와 `agents/openai.yaml`의 `policy.allow_implicit_invocation: false`가 함께 있으며, 사람만 호출할 수 있음)이거나 모델 호출형(모델 또는 사용자가 호출할 수 있음)입니다. [.agents/invocation.md](./.agents/invocation.md)를 보세요.

[`ask-me`](./skills/engineering/ask-me/SKILL.md)는 사용자가 호출할 수 있는 모든 스킬과 그 관계를 지도로 그리는 라우터입니다. 문서 페이지를 다시 동기화하는 것과 같은 계기가 여기에도 적용됩니다. 사용자가 호출할 수 있는 스킬을 추가하거나, 이름을 바꾸거나, 제거하거나, 흐름에 들어맞는 방식을 바꿀 때마다 `ask-me`의 `SKILL.md`를 다시 읽고 갱신해서 지도가 정확하게 유지되게 하세요. 언급하지 않는 새 스킬이나, 여전히 안내하는 낡은 스킬이 있으면 그 라우터는 거짓말을 하는 것입니다.

기본 플러그인 설치 대상은 `engineering/`과 `productivity/`입니다. 스킬을 추가하거나 이름을 바꾸면 두 매니페스트의 `skills` 목록도 함께 갱신하고 설치본을 갱신합니다. 파일 수정 후 새 CLI 세션을 시작하세요.

이 저장소의 산문(`SKILL.md` 파일, 문서, `README.md`, `CHANGELOG.md`, ADR, changeset, 코드 주석) 어디에도 em 대시를 쓰지 않습니다. 문장이 em 대시를 쓰고 싶어 하면 쉼표, 콜론, 마침표, 괄호, 접속사 중 문장이 실제로 원하는 것으로 다시 쓰세요. 맹목적인 문자 치환은 절대 하지 마세요.

## CLI별 사용

설치한 스킬은 Claude Code에서 `/handstack-skills:스킬이름`, Codex CLI에서 `$handstack-skills:스킬이름`으로 호출합니다. 문서 본문의 `/name`은 스킬을 가리키는 축약 표기이며 실제 호출에는 위 접두사를 붙입니다. Claude Code에서는 `CLAUDE.md`, Codex CLI에서는 `AGENTS.md`를 프로젝트 지침으로 사용합니다. 다른 스킬을 사용하라는 지시는 현재 CLI의 스킬 로드 수단으로 해석하고, 전용 도구가 없으면 설치된 플러그인의 해당 `SKILL.md`를 읽어 따릅니다. 사용자 호출형 스킬은 사용자가 명시적으로 요청한 경우에만 실행합니다.

## Agent skills

### Triage labels

표준 이름이며 바뀌지 않습니다. `docs/agents/triage-labels.md`를 보세요. 이슈는 [`SCOPE.md`](./SCOPE.md)에 비추어 판단합니다.
