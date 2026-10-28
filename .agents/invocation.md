# 모델 호출형 대 사용자 호출형

이 저장소의 모든 `SKILL.md`는 스킬입니다. 이들을 가르는 한 가지 축은 **호출**, 곧 누가 도달할 수 있는가입니다.

- **사용자 호출형**: **사람이 이름을 입력할 때만** 도달할 수 있습니다. frontmatter에 `disable-model-invocation: true`(Claude Code)를, `agents/openai.yaml`에 `policy.allow_implicit_invocation: false`(Codex)를 설정하세요. `description`은 **사람용**입니다. 슬래시 명령을 훑어보는 사람이 읽는 한 줄 요약입니다. 트리거 목록("Use when the user says…")은 걷어 냅니다.
- **모델 호출형**: **모델 또는 사용자**가 도달할 수 있습니다. 기본값입니다. `disable-model-invocation`과 `agents/openai.yaml`의 `policy` 블록을 생략하세요. `description`은 **모델용**이며 자동 호출이 발동하도록 풍부한 트리거 문구("Use when the user wants…, mentions…, asks for…")를 유지합니다. 스킬이 모델 호출형으로 남아야 하는지 보는 기준: _모델이 이것을 자율적으로 유용하게 꺼내 쓸 수 있는가?_ (재사용은 스킬을 추출하는 이유이지 기준이 아닙니다.)

각 하니스는 사용자 호출형 스킬을 자기 방식으로 모델의 도달 범위에서 제외하므로, 사람 외에는 아무것도 그것을 발동할 수 없고 다른 스킬도 마찬가지입니다. 사용자 호출형 스킬은 모델 호출형 스킬을 호출할 수 있지만, 다른 사용자 호출형 스킬에는 절대 도달할 수 없습니다.

모든 스킬은 `SKILL.md` 옆에 `agents/openai.yaml`도 갖고 있습니다. Codex CLI 스킬 메타데이터를 담습니다. 스킬 선택기를 위한 `interface.display_name`과 `interface.short_description`, 그리고 사용자 호출형 스킬의 경우 `disable-model-invocation`과 짝을 이루는 `policy.allow_implicit_invocation: false`입니다. 둘을 동기화하세요. 스킬은 두 하니스에서 모두 사용자 호출형이거나 둘 다 아니어야 합니다.

버킷 `README.md`와 최상위 `README.md`는 항목을 **사용자 호출형**과 **모델 호출형**으로 묶습니다.

## 플러그인 스킬 이름

Claude Code는 `/junchul-skills:name`, Codex CLI는 `$junchul-skills:name`으로 호출합니다. 플러그인 내부의 다른 스킬을 로드할 때도 `junchul-skills:`가 붙은 이름을 지정하세요. [설정 안내](./install-block.md)를 참고하세요.

## 둘 사이의 의존성

공유 스킬의 의존성은 대상 스킬 이름을 명시해서 표현합니다. Claude Code에서는 제공되는 Skill 도구로 모델 호출형 스킬을 로드합니다. Codex CLI에서는 스킬 이름과 로컬 파일 경로를 확인하고 해당 `SKILL.md` 및 필요한 보조 파일을 읽어 실행합니다. Claude Code 전용 도구 이름이 보이면 Codex CLI에 같은 도구가 있다고 가정하지 마세요.

사용자 호출형 선행 스킬이 필요하면 사용자에게 Claude Code의 `/junchul-skills:setup-me-skills` 또는 Codex CLI의 `$junchul-skills:setup-me-skills`로 명시적으로 요청하도록 안내합니다. 모델 호출형 스킬 두 개가 필요하면 두 스킬의 지침을 각각 로드하세요.

## 수동적 대 능동적 도메인 작업

어휘를 얻으려고 `GLOSSARY.md`를 _읽기만_ 하는 것은 한 줄짜리 산문 포인터이지 `domain-modeling` 스킬이 아닙니다. 능동적으로 구축하고 다듬는 규율(용어에 이의 제기, 엣지 케이스 시나리오, ADR 작성, `GLOSSARY.md` 인라인 갱신)만이 `domain-modeling`입니다.
