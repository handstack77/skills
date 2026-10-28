# 진행 중

베타 스킬입니다. 기본 플러그인 설치 대상에 포함하지 않으며, 동작이 바뀌거나 제거될 수 있습니다. 정식 버킷으로 승격된 스킬은 매니페스트에 포함한 뒤 [플러그인 설정 안내](../../.agents/install-block.md)에 따라 설치본을 갱신합니다.

- **[loop-me](./loop-me/SKILL.md)**: 현재 디렉터리를 상태가 있는 작업 공간으로 삼아 여러 세션에 걸쳐 스스로를 집요하게 질문해 구현 가능한 워크플로 명세로 만듭니다. 사용자 호출형.
- **[writing-beats](./writing-beats/SKILL.md)**: 글을 비트의 여정으로, 선택형 모험 방식으로 다듬습니다. 시작 비트를 고르고, 그 비트만 쓰고, 글이 자연스러운 끝에 도달할 때까지 다음으로 방향을 틉니다.
- **[writing-fragments](./writing-fragments/SKILL.md)**: 당신에게서 조각(이질적인 글의 알갱이)을 캐내는 집요한 질문 세션이며, 미래의 글을 위한 원자료로 하나의 문서에 덧붙입니다.
- **[writing-shape](./writing-shape/SKILL.md)**: 원자료가 담긴 마크다운 파일을 받아 문단 단위로 글로 다듬으며, 단계마다 형식 선택을 논쟁합니다.
- **[claude-handoff](./claude-handoff/SKILL.md)**: 현재 대화를 `claude --bg`로 인수인계 요약을 씨앗으로 삼은 새 백그라운드 에이전트에게 인계해서 즉시 작업을 이어받게 합니다. 사용자 호출형.
- **[setup-ts-deep-modules](./setup-ts-deep-modules/SKILL.md)**: TypeScript 저장소에 dependency-cruiser를 연결해 각 패키지를 깊은 모듈로 만듭니다. 구현은 하위 폴더에 숨기고, 진입점 파일을 통해서만 접근할 수 있으며, 테스트도 그것을 통해 실행합니다. 사용자 호출형.
