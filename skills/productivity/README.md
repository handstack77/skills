# 생산성

코드에 국한되지 않는 일반 워크플로 도구입니다.

## 사용자 호출형

직접 입력할 때만 호출할 수 있습니다(Claude Code: `disable-model-invocation: true`, Codex: `agents/openai.yaml`의 `policy.allow_implicit_invocation: false`).

- **[grill-me](./grill-me/SKILL.md)**: 설계 트리의 모든 가지가 해결될 때까지 계획이나 설계에 대해 집요하게 인터뷰를 받습니다.
- **[handoff](./handoff/SKILL.md)**: 현재 대화를 인수인계 문서로 압축해서 다른 에이전트가 작업을 이어갈 수 있게 합니다.
- **[teach](./teach/SKILL.md)**: 현재 디렉터리를 상태가 있는 교육 작업 공간으로 삼아 여러 세션에 걸쳐 사용자에게 새로운 기술이나 개념을 가르칩니다.
- **[to-questionnaire](./to-questionnaire/SKILL.md)**: 혼자서는 답할 수 없는 결정을, 답할 수 있는 한 사람을 위한 Markdown 설문지로 바꿉니다(비동기로 채우거나 회의에서 함께 채움).
- **[wait-what](./wait-what/SKILL.md)**: 메시지가 전달되지 않는 순간 바로 호출하세요. 에이전트가 당신이 모르는 맥락과 함께 쉬운 영어로, `GLOSSARY.md` 어휘를 써서 다시 설명합니다.

## 모델 호출형

모델 또는 사용자가 호출할 수 있습니다(모델이 꺼내 쓸 수 있도록 트리거 문구가 풍부합니다).

- **[grilling](./grilling/SKILL.md)**: 설계 트리의 모든 가지가 해결될 때까지 계획, 결정, 아이디어에 대해 사용자를 집요하게 인터뷰합니다.
- **[writing-for-agents](./writing-for-agents/SKILL.md)**: 에이전트를 위한 문서 작성입니다. 스킬, AGENTS.md/CLAUDE.md, 에이전트가 포인터로 도달하는 모든 문서가 해당합니다.
