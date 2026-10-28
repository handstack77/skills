# 하니스의 네이티브 질문 도구를 통한 집요한 질문

집요한 질문 세션(`/grilling`, `/grill-me`, `/grill-with-docs`, 그리고 다른 스킬 안의 집요한 질문)은 질문을 평범한 채팅 텍스트로 합니다. 하니스에 내장된 질문 UI(Claude Code의 `AskUserQuestion`, 호스트의 "질문 도구", 구조화되거나 일괄 처리되는 설문 모드)를 거치게 해 달라는 요청은 범위 밖입니다.

## 범위 밖인 이유

스킬은 Claude Code와 Codex CLI에서 함께 사용하는 텍스트입니다. 두 CLI의 질문 도구와 호출 방법이 다를 수 있으므로 공유 스킬은 일반 대화로 질문합니다. CLI별 UI 선호는 프로젝트의 `CLAUDE.md` 또는 `AGENTS.md`에 기록합니다.

질문 UI는 집요한 질문 자체도 바꿉니다. 구조화된 선택기는 모델을 미리 만들어 둔 답이 있는 객관식 질문으로 밀어붙이는데, 이는 집요한 질문의 목적과 정반대입니다. 목적은 결정 트리의 한 가지씩 자기 말로 답하는 열린 질문입니다. `AskUserQuestion` UI를 써 봤고, 이 스킬들에는 원하지 않습니다.

하니스의 질문 도구를 선호한다면 자신의 `CLAUDE.md` / `AGENTS.md`에 적으세요("집요하게 질문할 때는 AskUserQuestion으로 물어라"). 사용자별 한 줄짜리 선호이며, 공유 스킬이 그것을 알 필요는 없습니다.

## 이전 요청

- #19: "grill-me: not always using the question tool"
- #643: "Proposal: Use AskQuestion for structured input during grilling sessions"
- #840: "Use host's question tool for grilling sessions"
- #1107: "Grilling doesn't use Agent's native QA tool OOTB"
- #1152: "Proposal: experimental HTML questionnaire mode for batch grilling"
