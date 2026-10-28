# 엔지니어링

코드 작업에 매일 쓰는 스킬입니다.

## 사용자 호출형

직접 입력할 때만 호출할 수 있습니다(Claude Code: `disable-model-invocation: true`, Codex: `agents/openai.yaml`의 `policy.allow_implicit_invocation: false`).

- **[ask-me](./ask-me/SKILL.md)**: 내 상황에 어떤 스킬이나 흐름이 맞는지 물어보세요. 이 저장소의 사용자 호출형 스킬들을 연결해 주는 라우터입니다.
- **[grill-with-docs](./grill-with-docs/SKILL.md)**: 프로젝트의 도메인 모델도 함께 만드는 집요한 질문 세션입니다. 용어를 다듬고 `GLOSSARY.md`와 ADR을 그 자리에서 갱신합니다.
- **[triage](./triage/SKILL.md)**: 이슈를 트리아지 역할의 상태 머신에 따라 이동시킵니다.
- **[improve-codebase-architecture](./improve-codebase-architecture/SKILL.md)**: 코드베이스에서 깊게 만들 기회를 스캔하고, 시각적인 HTML 보고서로 제시한 뒤, 고른 항목을 집요하게 검증합니다.
- **[setup-me-skills](./setup-me-skills/SKILL.md)**: 이 저장소를 엔지니어링 스킬용으로 설정합니다(이슈 트래커, 트리아지 라벨, 도메인 문서 레이아웃). 저장소당 한 번 실행합니다.
- **[to-spec](./to-spec/SKILL.md)**: 현재 대화를 명세로 바꿔 이슈 트래커에 게시합니다.
- **[to-tickets](./to-tickets/SKILL.md)**: 계획, 명세, 대화를 트레이서 불릿 티켓 묶음으로 나눕니다. 각 티켓은 차단 관계를 선언하며, 로컬 파일의 텍스트나 실제 트래커의 네이티브 차단 링크로 표현합니다.
- **[implement](./implement/SKILL.md)**: 명세나 티켓 묶음에 설명된 작업을 구현합니다. 사전에 합의한 이음매에서 `/tdd`를 몰고, 커밋하기 전에 `/code-review`로 마무리합니다.
- **[implement-spec](./implement-spec/SKILL.md)**: 명세 전체를 하나의 통합 브랜치에서 구현합니다. 티켓을 작업 그래프로 다루며, 준비된 프런티어에 걸쳐 구현자 서브에이전트를 실행해 동시성을 최대로 높이고, `/code-review`로 마무리합니다.
- **[wayfinder](./wayfinder/SKILL.md)**: 에이전트 세션 하나로는 담을 수 없는 아주 큰 작업을 이슈 트래커 위의 의사결정 티켓 공유 지도로 계획하고, 목적지로 가는 길이 분명해질 때까지 하나씩 해결합니다.
- **[retro](./retro/SKILL.md)**: 세션 뒤에 코딩 에이전트의 환경(탐색, 자동 검사, 코딩 표준, 조종용 파일, 도구)에 대한 개선안을 심각도 순으로 제안합니다.

## 모델 호출형

모델 또는 사용자가 호출할 수 있습니다(모델이 꺼내 쓸 수 있도록 트리거 문구가 풍부합니다).

- **[prototype](./prototype/SKILL.md)**: 설계 질문에 답하는 일회용 프로토타입을 만듭니다. 상태/로직에는 공유 가능한 HTML 파일 하나, UI에는 전환 가능한 여러 변형입니다.

- **[diagnosing-bugs](./diagnosing-bugs/SKILL.md)**: 까다로운 버그와 성능 회귀를 위한 규율 있는 진단 루프입니다. 이 버그에서 빨갛게 되는 피드백 루프를 만들고 → 최소화 → 가설 → 계측 → 수정 → 회귀 테스트.
- **[research](./research/SKILL.md)**: 신뢰도 높은 1차 자료를 근거로 질문을 조사하고, 결과를 출처가 달린 Markdown 파일로 저장소에 남깁니다. 백그라운드 에이전트로 실행합니다.
- **[tdd](./tdd/SKILL.md)**: red-green-refactor 루프를 쓰는 테스트 주도 개발입니다. 한 번에 수직 슬라이스 하나씩 기능을 만들거나 버그를 고칩니다.
- **[domain-modeling](./domain-modeling/SKILL.md)**: 용어에 이의를 제기하고, 시나리오로 압박 테스트를 하고, `GLOSSARY.md`와 ADR을 그 자리에서 갱신하면서 프로젝트의 도메인 모델을 능동적으로 구축하고 다듬습니다.
- **[codebase-design](./codebase-design/SKILL.md)**: 깊은 모듈을 설계하기 위한 공용 규율과 어휘입니다. 작은 인터페이스, 깔끔한 이음매, 인터페이스를 통한 테스트 가능성.
- **[code-review](./code-review/SKILL.md)**: 고정된 기준점 이후 diff에 대한 두 축 리뷰입니다. **표준**(저장소의 코딩 표준과 Fowler 스멜 기준선을 따르는가?)과 **명세**(원래 이슈/명세를 충실히 구현하는가?)를 병렬 서브에이전트로 실행합니다.
- **[pr](./pr/SKILL.md)**: 풀 리퀘스트 본문이 취해야 할 형태입니다. 변경을 분명히 하는 가장 작은 시각 자료로서의 요약, 동작함을 보여 주는 이전/이후 증거, 병합 위험 판단(일방향 또는 양방향 문, 그리고 영향 범위).
- **[wizard](./wizard/SKILL.md)**: 사람만 수행할 수 있는 단계를 안내하는 대화형 bash 마법사를 생성합니다. 인프라 프로비저닝, 자격 증명이나 CI 시크릿 설정, 낯선 서드파티 대시보드 따라가기, 일회성 마이그레이션이나 전환 작업.
