# ADR 0002: 로컬 마켓플레이스를 통한 플러그인 설치

## 결정

스킬 원본은 이 문서 기준 `../..`인 저장소 루트에서 관리합니다. 이 디렉토리를 Claude Code와 Codex CLI의 로컬 마켓플레이스로 등록하고 `junchul-skills@junchul` 플러그인으로 설치합니다.

## 적용

- 마켓플레이스 이름은 `junchul`, 플러그인 이름은 `junchul-skills`입니다.
- `.claude-plugin/marketplace.json`과 `.claude-plugin/plugin.json`에서 `engineering/`과 `productivity/`의 정식 스킬 27개를 동일하게 지정합니다.
- Claude Code는 `/junchul-skills:name`, Codex CLI는 `$junchul-skills:name`으로 호출합니다.
- 등록, 설치, 갱신, 제거 명령은 [설정 안내](../install-block.md#plugin-install)를 기준으로 합니다.
- `misc/`, `in-progress/`, `deprecated/`는 기본 플러그인 설치 대상에 포함하지 않습니다.

## 이유와 영향

두 CLI가 사용할 스킬의 원본을 한 디렉토리에서 관리하고, 각 CLI의 플러그인 명령으로 설치 상태를 관리합니다. 원본을 수정하거나 스킬 이름을 바꾸면 매니페스트와 설치본을 갱신하고 새 세션에서 확인합니다. 원본 디렉토리를 옮기면 마켓플레이스 경로도 갱신해야 합니다.

프로젝트별 지침은 Claude Code의 `CLAUDE.md`와 Codex CLI의 `AGENTS.md`에서 공유 문서인 `docs/agents/*.md`를 가리키도록 유지합니다.
