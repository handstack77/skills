# 플러그인 기반 스킬 설정

이 스킬 모음은 Claude Code와 Codex CLI에서 사용합니다. 원본은 이 문서 기준 `..`에 있는 저장소 루트입니다. 이 디렉토리를 로컬 마켓플레이스로 등록한 뒤 플러그인을 설치합니다.

<a id="plugin-install"></a>

## 로컬 마켓플레이스에서 플러그인 설치

이 디렉토리의 `.claude-plugin/marketplace.json`을 두 CLI가 읽습니다. 마켓플레이스 이름은 `junchul`, 플러그인 이름은 `junchul-skills`입니다. 정식 스킬 27개를 포함하며, `misc`, `in-progress`, `deprecated`는 제외합니다. 아래 명령은 저장소 루트(`README.md`와 `.claude-plugin/`이 있는 디렉토리)에서 실행하세요. 명령의 `./`는 현재 작업 디렉토리인 저장소 루트를 뜻합니다. 로컬 경로는 `./`처럼 접두사가 있어야 하며 `.`만 쓰면 거부됩니다. 명령 프롬프트(cmd)나 터미널(macOS, Linux)에서 사용할 CLI의 명령만 실행하세요.

### Claude Code

```shell
claude plugin marketplace add ./
claude plugin install junchul-skills@junchul --scope user
claude plugin list
```

새 Claude Code 세션에서 `/junchul-skills:setup-me-skills`를 실행합니다.

### Codex CLI

```shell
codex plugin marketplace add ./
codex plugin add junchul-skills@junchul
codex plugin list --marketplace junchul
```

새 Codex CLI 세션에서 `$junchul-skills:setup-me-skills`를 실행합니다. `/skills`에서 `junchul-skills:` 접두사가 붙은 스킬을 선택해도 됩니다.

### 스킬 호출

| Claude Code | Codex CLI |
| --- | --- |
| `/junchul-skills:setup-me-skills` | `$junchul-skills:setup-me-skills` |

다른 스킬도 같은 규칙을 씁니다. 예를 들어 플러그인의 리뷰 스킬은 Claude Code에서 `/junchul-skills:code-review`, Codex CLI에서 `$junchul-skills:code-review`입니다.

## 실행과 프로젝트 설정

설치 후 실행 중인 CLI를 종료하고 새 세션을 시작합니다. 작업할 프로젝트 디렉토리에서 `claude` 또는 `codex`를 실행하세요.

- Claude Code: `/junchul-skills:setup-me-skills`
- Codex CLI: `$junchul-skills:setup-me-skills`

이 스킬은 현재 작업 프로젝트의 이슈 트래커, 트리아지 라벨, 도메인 문서 위치를 설정합니다. Claude Code의 프로젝트 지침은 `CLAUDE.md`, Codex CLI의 프로젝트 지침은 `AGENTS.md`에 둡니다.

Claude Code에서는 `/` 메뉴에서 스킬 이름을 확인하고, Codex CLI에서는 `/skills`에서 확인합니다. 설치한 플러그인의 `SKILL.md`를 읽는지 확인하세요.

## 플러그인 갱신과 제거

원본 파일을 수정한 후 설치된 플러그인을 갱신하고 새 세션을 시작합니다. 자동 갱신을 가정하지 마세요. 설치 목록과 실제로 읽는 스킬 경로를 확인합니다.

설치된 플러그인은 원본이 아니라 캐시에 복사된 사본을 읽습니다. 버전이 같으면 갱신 명령이 변경을 반영하지 않을 수 있으므로, 갱신 전에 `.claude-plugin/plugin.json`의 `version`을 올립니다. 스킬을 추가하거나 이름을 바꾸면 `.claude-plugin/marketplace.json`과 `plugin.json`의 `skills` 목록도 함께 고칩니다.

```json
"version": "1.3.2"
```

Claude Code는 마켓플레이스 정보를 먼저 새로 읽은 뒤 플러그인을 갱신합니다.

```shell
claude plugin marketplace update junchul
claude plugin update junchul-skills@junchul
claude plugin list
```

`claude plugin list`에서 설치된 버전이 올린 버전과 같은지 확인합니다.

Codex CLI에는 현재 설치 명령의 강제 갱신 옵션이 없으므로 로컬 원본을 다시 가져오려면 제거 후 재설치합니다.

```shell
codex plugin remove junchul-skills@junchul
codex plugin add junchul-skills@junchul
```

플러그인 사용을 끝낼 때는 Claude Code에서 `claude plugin uninstall junchul-skills@junchul --scope user`, Codex CLI에서 `codex plugin remove junchul-skills@junchul`를 실행합니다. 스킬 원본 디렉토리는 별도로 관리합니다.

검증에 사용한 CLI는 Claude Code 2.1.310과 Codex CLI 0.162.1입니다. 명령이 없는 이전 CLI를 사용한다면 플러그인 명령을 지원하는 버전으로 갱신하세요.

## 문서 작성 기준

설정 안내는 이 문서를 기준으로 작성합니다. 원본 경로, 마켓플레이스 등록, 플러그인 설치, CLI별 호출 방법과 갱신 절차를 함께 설명하세요. 스킬 이름에는 `junchul-skills:` 접두사를 포함합니다.

근거: [Claude Code 로컬 마켓플레이스](https://code.claude.com/docs/en/plugin-marketplaces), [공식 OpenAI 문서의 Codex CLI 플러그인 명령](https://learn.chatgpt.com/docs/cli/reference).
