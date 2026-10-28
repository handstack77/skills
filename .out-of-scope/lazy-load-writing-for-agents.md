# 에이전트용 글쓰기를 판단하는 스킬에서 `writing-for-agents` 지연 로드

`retro`는 쓰기 전에만이 아니라 실행할 때마다 `writing-for-agents`를 로드합니다. 스킬이 스킬, `AGENTS.md`/`CLAUDE.md`, 문서를 편집할 때까지 그 로드를 미뤄 달라는 요청은 범위 밖입니다.

## 범위 밖인 이유

`writing-for-agents`는 스타일 가이드 이상입니다. 무효 지시가 무엇인지, 좋은 스킬이 무엇인지 정의하며, `retro`는 무언가를 쓰기 전에 읽은 조종용 파일을 판단하는 데 그 정의를 씁니다. 읽고 보고하기만 하는 회고도 이것이 필요합니다. 지연 로드하면 무효 지시와 스킬 후보를 기준 없이 판단하게 됩니다.

## 이전 요청

- #1238: "retro: load writing-for-agents only before writing" (closed)
