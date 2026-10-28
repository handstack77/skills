# 범위

이 저장소는 제가 매일 쓰는 스킬 모음입니다. 선별된 모음이며, 아이디어는 환영하고 각각은 아래의 기준으로 판단합니다. 이슈는 스킬의 변경을 추적하기 위한 것입니다. 질문과 토론은 GitHub Discussions로 보내 주세요.

## 기준

아이디어나 피드백 이슈는 **두 부분을 모두** 통과해야 열린 채로 남습니다.

1. **관찰된 실패.** 실제 세션에서 잘못된 일을 서술합니다. 무엇을 실행했고, 스킬이 무엇을 했고, 무엇을 기대했는지. 가상의 개선("...하면 더 좋겠다")은 이 부분을 통과하지 못합니다.
2. **철학에 맞음.** [`.out-of-scope/`](./.out-of-scope/)의 어떤 것이나 과거의 기각과 일치하지 않고, 설정 옵션도, 특정 하니스 전용 분기도, 한 사람의 워크플로에 맞추려는 조정도 아닙니다. 그런 것들은 여러분 자신의 `CLAUDE.md` / `AGENTS.md`나 로컬 원본의 개인 수정에 속합니다.

크기는 무관합니다. 한 단어 수정과 전면 재작성이 같은 기준에 직면합니다. 반응과 +1 댓글은 기준에 반영되지 않습니다.

## 버킷별

- **`engineering/`, `productivity/`, `in-progress/`**: 위의 기준.
- **`misc/`**: 동결되어 유지보수되지 않습니다. 모든 이슈는 닫힙니다. [`frozen-misc-skills.md`](./.out-of-scope/frozen-misc-skills.md)를 보세요.
- **새 스킬**: 제안과 기여는 닫혀 있습니다. 동작이 기존 스킬로 조합된다면 새 스킬을 받지 못합니다. [`new-skills.md`](./.out-of-scope/new-skills.md)를 보세요.

## 이미 결정된 것

[`.out-of-scope/`](./.out-of-scope/)의 각 파일은 기각된 개념 하나와 그 이유를 기록합니다. 이슈를 올리기 전에 읽어 주세요.

- [`frozen-misc-skills.md`](./.out-of-scope/frozen-misc-skills.md)
- [`harness-name-collisions.md`](./.out-of-scope/harness-name-collisions.md)
- [`mainstream-issue-trackers-only.md`](./.out-of-scope/mainstream-issue-trackers-only.md)
- [`native-question-tool.md`](./.out-of-scope/native-question-tool.md)
- [`new-skills.md`](./.out-of-scope/new-skills.md)
- [`question-limits.md`](./.out-of-scope/question-limits.md)
- [`setup-skill-verify-mode.md`](./.out-of-scope/setup-skill-verify-mode.md)
- [`subagent-recursion.md`](./.out-of-scope/subagent-recursion.md)

## 불분명한 이슈

기준에 비추어 판단할 수 없는 이슈는 질문 한 라운드와 `needs-info` 라벨을 받습니다. 제보자의 답이 14일 동안 없으면 닫힙니다. 기각은 "not planned"로 닫힙니다.
