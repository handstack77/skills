# 진짜 엔지니어를 위한 스킬

바이브 코딩이 아니라 진짜 엔지니어링을 하려고 제가 매일 쓰는 에이전트 스킬입니다.

실제 애플리케이션을 개발하는 것은 어렵습니다. GSD, BMAD, Spec-Kit 같은 접근법은 프로세스를 소유함으로써 도우려 합니다. 하지만 그렇게 하면서 여러분의 통제권을 빼앗고, 프로세스의 버그를 해결하기 어렵게 만듭니다.

이 스킬들은 작고, 적응시키기 쉽고, 조합할 수 있게 설계되었습니다. Claude Code와 Codex CLI에서 사용할 수 있습니다. 수십 년의 엔지니어링 경험에 기반합니다. 마음껏 손을 대 보세요. 여러분의 것으로 만드세요. 즐기세요.

## 플러그인 설정

저장소 루트 `.`을 로컬 마켓플레이스로 등록하고 `junchul-skills@junchul`을 설치합니다.

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

갱신과 제거 명령은 [설정 안내](./.agents/install-block.md)의 플러그인 절차를 참고하세요.

## 이 스킬들이 존재하는 이유

Claude Code와 Codex CLI에서 제가 보는 흔한 실패 양상을 고치려고 이 스킬들을 만들었습니다.

### #1: 에이전트가 제가 원하는 대로 하지 않았다

> "정확히 무엇을 원하는지는 아무도 모른다."
>
> David Thomas & Andrew Hunt, [The Pragmatic Programmer](https://www.amazon.co.uk/Pragmatic-Programmer-Anniversary-Journey-Mastery/dp/B0833F1T3V)

**문제.** 소프트웨어 개발에서 가장 흔한 실패 양상은 어긋남입니다. 개발자가 내가 원하는 것을 안다고 생각하다가, 그가 만든 것을 보고 나서 전혀 이해하지 못했다는 것을 깨닫습니다.

AI 시대에도 똑같습니다. 당신과 에이전트 사이에는 소통의 틈이 있습니다. 이를 고치는 방법은 **집요한 질문 세션(grilling session)**입니다. 에이전트가 당신이 만드는 것에 대해 상세한 질문을 하게 하는 것입니다.

**해결책**은 다음을 쓰는 것입니다.

- [`/grill-me`](./skills/productivity/grill-me/SKILL.md) - 코드가 아닌 용도
- [`/grill-with-docs`](./skills/engineering/grill-with-docs/SKILL.md) - [`/grill-me`](./skills/productivity/grill-me/SKILL.md)와 같지만 덤이 더 있습니다 (아래 참고)

이것들은 가장 인기 있는 스킬입니다. 시작하기 전에 에이전트와 정렬하고, 만들고 있는 변경에 대해 깊이 생각하도록 도와줍니다. 변경하고 싶을 때마다 _언제나_ 쓰세요.

### #2: 에이전트가 너무 장황하다

> 공용어(ubiquitous language)가 있으면 개발자들 사이의 대화와 코드의 표현이 모두 같은 도메인 모델에서 나온다.
>
> Eric Evans, [Domain-Driven-Design](https://www.amazon.co.uk/Domain-Driven-Design-Tackling-Complexity-Software/dp/0321125215)

**문제**: 프로젝트 초반에 개발자와 그들이 소프트웨어를 만들어 주는 상대(도메인 전문가)는 보통 서로 다른 언어를 말합니다.

저는 에이전트와도 같은 긴장을 느꼈습니다. 에이전트는 보통 프로젝트에 던져져서 전문 용어를 진행하면서 알아내라는 요구를 받습니다. 그래서 1단어면 될 것을 20단어로 씁니다.

이를 고치는 **해결책**은 공유 언어입니다. 에이전트가 프로젝트에서 쓰이는 전문 용어를 해독하도록 돕는 문서입니다.

<details>
<summary>
예시
</summary>

- **BEFORE**: "There's a problem when a lesson inside a section of a course is made 'real' (i.e. given a spot in the file system)"
- **AFTER**: "There's a problem with the materialization cascade"

이 간결함은 세션이 거듭될수록 값을 합니다.

</details>

이것은 [`/grill-with-docs`](./skills/engineering/grill-with-docs/SKILL.md)에 내장되어 있습니다. 집요한 질문 세션이지만, AI와 공유 언어를 구축하고 설명하기 어려운 결정을 ADR로 문서화하도록 도와줍니다.

이것이 얼마나 강력한지 설명하기는 어렵습니다. 이 저장소에서 가장 멋진 기법 하나일 수 있습니다. 써 보고 확인해 보세요.

> [!TIP]
> 공유 언어에는 장황함을 줄이는 것 외에도 많은 이점이 있습니다.
>
> - **변수, 함수, 파일이 공유 언어를 사용해 일관되게 이름 붙여집니다**
> - 그 결과 에이전트에게 **코드베이스가 탐색하기 더 쉬워집니다**
> - 에이전트는 더 간결한 언어를 쓸 수 있으므로 **생각에 토큰을 덜 씁니다**

### #3: 코드가 동작하지 않는다

> "항상 작고 신중한 걸음을 내딛어라. 피드백의 속도가 당신의 속도 제한이다. 너무 큰 과업은 절대 맡지 마라."
>
> David Thomas & Andrew Hunt, [The Pragmatic Programmer](https://www.amazon.co.uk/Pragmatic-Programmer-Anniversary-Journey-Mastery/dp/B0833F1T3V)

**문제**: 당신과 에이전트가 무엇을 만들지에 대해 정렬되었다고 해 봅시다. 에이전트가 _그래도_ 쓰레기를 만들어 내면 어떻게 될까요?

피드백 루프를 볼 때입니다. 자기가 만든 코드가 실제로 어떻게 실행되는지에 대한 피드백이 없으면 에이전트는 눈을 감고 비행하는 셈입니다.

**해결책**: 일반적인 피드백 루프 묶음이 필요합니다. 정적 타입, 브라우저 접근, 자동화된 테스트입니다.

자동화된 테스트에서는 red-green-refactor 루프가 결정적입니다. 에이전트가 실패하는 테스트를 먼저 쓰고, 그다음 테스트를 고칩니다. 이것이 에이전트에게 일관된 수준의 피드백을 주어 훨씬 더 나은 코드를 만듭니다.

어떤 프로젝트에든 끼워 넣을 수 있는 **[`/tdd`](./skills/engineering/tdd/SKILL.md) 스킬**을 만들었습니다. red-green-refactor를 장려하고, 좋은 테스트와 나쁜 테스트가 무엇인지에 대해 에이전트에게 충분한 지침을 줍니다.

디버깅을 위해서는 **[`/diagnosing-bugs`](./skills/engineering/diagnosing-bugs/SKILL.md)** 스킬도 만들었습니다. 최선의 디버깅 관행을 단계별로 관문을 둔 규율 있는 루프로 감쌌습니다.

### #4: 우리가 진흙 뭉치를 만들었다

> "시스템의 설계에 _매일_ 투자하라."
>
> Kent Beck, [Extreme Programming Explained](https://www.amazon.co.uk/Extreme-Programming-Explained-Embrace-Change/dp/0321278658)

> "최고의 모듈은 깊다. 단순한 인터페이스를 통해 많은 기능에 접근하게 해 준다."
>
> John Ousterhout, [A Philosophy Of Software Design](https://www.amazon.co.uk/Philosophy-Software-Design-2nd/dp/173210221X)

**문제**: 에이전트로 만든 대부분의 앱은 복잡하고 바꾸기 어렵습니다. 에이전트가 코딩을 극적으로 가속할 수 있으므로 소프트웨어 엔트로피도 가속합니다. 코드베이스는 전례 없는 속도로 더 복잡해집니다.

이를 고치는 **해결책**은 AI 기반 개발에 대한 근본적으로 새로운 접근법입니다. 코드의 설계를 신경 쓰는 것입니다.

이것은 이 스킬들의 모든 계층에 내장되어 있습니다.

- [`/to-spec`](./skills/engineering/to-spec/SKILL.md)은 명세를 만들기 전에 어떤 모듈을 건드리는지 퀴즈를 냅니다

그리고 결정적으로 [`/improve-codebase-architecture`](./skills/engineering/improve-codebase-architecture/SKILL.md)는 코드베이스에서 깊게 만들 기회를 조사해 후보를 건네줍니다. 며칠에 한 번 코드베이스에 실행하기를 권합니다. 조사이지 구조 작업이 아닙니다. 정말 오래된 코드베이스에서는 실제 후보를 찾아내겠지만, 진흙을 대신 풀어 주지는 않습니다.

### 요약

소프트웨어 엔지니어링의 기본기는 그 어느 때보다 중요합니다. 이 스킬들은 그 기본기를 반복 가능한 관행으로 압축하려는 저의 최선의 노력이며, 여러분이 경력 최고의 앱을 출시하도록 돕습니다. 즐기세요.

## 참고

이 스킬들은 한 가지 축으로 나뉩니다. 누가 호출할 수 있는가입니다. **사용자 호출형** 스킬은 직접 입력할 때만 호출할 수 있고(예: `/grill-me`), 조율이 임무입니다. **모델 호출형** 스킬은 당신이 호출하거나 과업이 맞을 때 에이전트가 자동으로 꺼내 쓸 수 있고, 재사용 가능한 규율을 담고 있습니다. 사용자 호출형 스킬은 모델 호출형 스킬을 호출할 수 있지만, 다른 사용자 호출형 스킬은 절대 호출하지 않습니다.

### 엔지니어링

코드 작업에 매일 쓰는 스킬입니다.

**사용자 호출형**

- **[ask-me](./skills/engineering/ask-me/SKILL.md)**: 내 상황에 어떤 스킬이나 흐름이 맞는지 물어보세요. 이 저장소의 사용자 호출형 스킬들을 연결해 주는 라우터입니다.
- **[grill-with-docs](./skills/engineering/grill-with-docs/SKILL.md)**: 프로젝트의 도메인 모델도 함께 만드는 집요한 질문 세션입니다. 용어를 다듬고 `GLOSSARY.md`와 ADR을 그 자리에서 갱신합니다.
- **[triage](./skills/engineering/triage/SKILL.md)**: 이슈를 트리아지 역할의 상태 머신에 따라 이동시킵니다.
- **[improve-codebase-architecture](./skills/engineering/improve-codebase-architecture/SKILL.md)**: 코드베이스에서 깊게 만들 기회를 스캔하고, 시각적인 HTML 보고서로 제시한 뒤, 고른 항목을 집요하게 검증합니다.
- **[setup-me-skills](./skills/engineering/setup-me-skills/SKILL.md)**: 이 저장소를 엔지니어링 스킬용으로 설정합니다(이슈 트래커, 트리아지 라벨, 도메인 문서 레이아웃). 다른 엔지니어링 스킬을 쓰기 전에 저장소당 한 번 실행합니다.
- **[to-spec](./skills/engineering/to-spec/SKILL.md)**: 현재 대화를 명세로 바꿔 이슈 트래커에 게시합니다. 인터뷰 없이, 이미 논의한 내용을 종합하기만 합니다.
- **[to-tickets](./skills/engineering/to-tickets/SKILL.md)**: 계획, 명세, 대화를 트레이서 불릿 티켓 묶음으로 나눕니다. 각 티켓은 차단 관계를 선언하며, 로컬 파일의 텍스트나 실제 트래커의 네이티브 차단 링크로 씁니다.
- **[implement](./skills/engineering/implement/SKILL.md)**: 명세나 티켓 묶음에 설명된 작업을 구현합니다. 사전에 합의한 이음매에서 `/tdd`를 몰고, 커밋하기 전에 `/code-review`로 마무리합니다.
- **[implement-spec](./skills/engineering/implement-spec/SKILL.md)**: 명세 전체를 하나의 통합 브랜치에서 구현합니다. 티켓을 작업 그래프로 다루며, 준비된 프런티어에 걸쳐 구현자 서브에이전트를 실행해 동시성을 최대로 높이고, `/code-review`로 마무리합니다.
- **[wayfinder](./skills/engineering/wayfinder/SKILL.md)**: 에이전트 세션 하나로는 담을 수 없는 아주 큰 작업을 이슈 트래커 위의 의사결정 티켓 공유 지도로 계획하고, 목적지로 가는 길이 분명해질 때까지 하나씩 해결합니다.
- **[retro](./skills/engineering/retro/SKILL.md)**: 세션 뒤에 코딩 에이전트의 환경(탐색, 자동 검사, 코딩 표준, 조종용 파일, 도구)에 대한 개선안을 심각도 순으로 제안합니다.

**모델 호출형**

- **[prototype](./skills/engineering/prototype/SKILL.md)**: 설계 질문에 답하는 일회용 프로토타입을 만듭니다. 상태/로직 질문에는 공유 가능한 HTML 파일 하나, 또는 한 라우트에서 전환할 수 있는 근본적으로 다른 UI 변형 여러 개입니다.
- **[diagnosing-bugs](./skills/engineering/diagnosing-bugs/SKILL.md)**: 까다로운 버그와 성능 회귀를 위한 규율 있는 진단 루프입니다. 이 버그에서 빨갛게 되는 피드백 루프를 만들고 → 최소화 → 가설 → 계측 → 수정 → 회귀 테스트.
- **[research](./skills/engineering/research/SKILL.md)**: 신뢰도 높은 1차 자료를 근거로 질문을 조사하고, 결과를 출처가 달린 Markdown 파일로 저장소에 남깁니다. 백그라운드 에이전트로 실행합니다.
- **[tdd](./skills/engineering/tdd/SKILL.md)**: red-green-refactor 루프를 쓰는 테스트 주도 개발입니다. 한 번에 수직 슬라이스 하나씩 기능을 만들거나 버그를 고칩니다.
- **[domain-modeling](./skills/engineering/domain-modeling/SKILL.md)**: 프로젝트의 도메인 모델을 능동적으로 구축하고 다듬습니다. 용어집에 비추어 용어에 이의를 제기하고, 엣지 케이스 시나리오로 압박 테스트를 하고, `GLOSSARY.md`와 ADR을 그 자리에서 갱신합니다.
- **[codebase-design](./skills/engineering/codebase-design/SKILL.md)**: 깊은 모듈을 설계하기 위한 공용 규율과 어휘입니다. 작은 인터페이스 뒤에 많은 동작이 있고, 깔끔한 이음매에 놓이며, 그 인터페이스를 통해 테스트할 수 있습니다.
- **[code-review](./skills/engineering/code-review/SKILL.md)**: 고정된 기준점 이후 diff에 대한 두 축 리뷰입니다. **표준**(저장소의 코딩 표준과 Fowler 스멜 기준선을 따르는가?)과 **명세**(원래 이슈/명세를 충실히 구현하는가?)를 서로 오염시키지 않도록 병렬 서브에이전트로 실행합니다.
- **[pr](./skills/engineering/pr/SKILL.md)**: 풀 리퀘스트 본문이 취해야 할 형태입니다. 변경을 분명히 하는 가장 작은 시각 자료로서의 요약, 동작함을 보여 주는 이전/이후 증거, 병합 위험 판단(일방향 또는 양방향 문, 그리고 영향 범위).
- **[wizard](./skills/engineering/wizard/SKILL.md)**: 사람만 수행할 수 있는 단계를 안내하는 대화형 bash 마법사를 생성합니다. 인프라 프로비저닝, 자격 증명이나 CI 시크릿 설정, 낯선 서드파티 대시보드 따라가기, 일회성 마이그레이션이나 전환 작업.

### 생산성

코드에 국한되지 않는 일반 워크플로 도구입니다.

**사용자 호출형**

- **[grill-me](./skills/productivity/grill-me/SKILL.md)**: 설계 트리의 모든 가지가 해결될 때까지 계획이나 설계에 대해 집요하게 인터뷰를 받습니다.
- **[handoff](./skills/productivity/handoff/SKILL.md)**: 현재 대화를 인수인계 문서로 압축해서 다른 에이전트가 작업을 이어갈 수 있게 합니다.
- **[teach](./skills/productivity/teach/SKILL.md)**: 현재 디렉터리를 상태가 있는 교육 작업 공간으로 삼아 여러 세션에 걸쳐 사용자에게 새로운 기술이나 개념을 가르칩니다.
- **[to-questionnaire](./skills/productivity/to-questionnaire/SKILL.md)**: 혼자서는 답할 수 없는 결정을, 답할 수 있는 한 사람을 위한 Markdown 설문지로 바꿉니다(비동기로 채우거나 회의에서 함께 채움). 주제가 아니라 전달(누구를 위한 것인지, 무엇을 돌려받아야 하는지)에 대해 집요하게 질문합니다.
- **[wait-what](./skills/productivity/wait-what/SKILL.md)**: 메시지가 전달되지 않는 순간 바로 호출하세요. 에이전트가 당신이 모르는 맥락과 함께 쉬운 영어로, `GLOSSARY.md` 어휘를 써서 다시 설명합니다.

**모델 호출형**

- **[grilling](./skills/productivity/grilling/SKILL.md)**: 설계 트리의 모든 가지가 해결될 때까지 계획, 결정, 아이디어에 대해 사용자를 집요하게 인터뷰합니다. `grill-me`, `grill-with-docs`, `triage`, `wayfinder`, `improve-codebase-architecture` 뒤에 있는 재사용 가능한 인터뷰 프리미티브입니다.
- **[writing-for-agents](./skills/productivity/writing-for-agents/SKILL.md)**: 에이전트를 위한 문서 작성입니다. 스킬, AGENTS.md/CLAUDE.md, 에이전트가 포인터로 도달하는 모든 문서가 해당합니다.
