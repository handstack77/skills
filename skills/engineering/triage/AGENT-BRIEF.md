# 에이전트 브리프 작성하기

에이전트 브리프는 GitHub 이슈나 PR이 `ready-for-agent`로 옮겨질 때 게시하는 구조화된 댓글입니다. AFK 에이전트가 작업의 근거로 삼을 권위 있는 명세입니다. 원래 본문과 논의는 맥락이고, 에이전트 브리프가 계약입니다.

브리프는 **에이전트가 해야 할 일**을 서술하며, 이는 두 접점 모두에 해당합니다. 이슈라면 아무것도 없는 상태에서 변경을 만드는 것이고, PR이라면 *기존 diff에* 남은 일, 즉 마무리하고, 빈틈을 메우고, 리뷰 지적을 처리하는 것입니다. 원칙은 어느 쪽이든 같습니다. 아래 PR 예시가 차이를 보여 줍니다.

## 원칙

### 정밀함보다 오래감

이슈는 `ready-for-agent`에서 며칠 또는 몇 주 머물 수 있습니다. 그동안 코드베이스는 바뀝니다. 파일 이름이 바뀌고, 옮겨지고, 리팩터링되더라도 브리프가 계속 유용하도록 쓰세요.

- 인터페이스, 타입, 행동 계약을 **기술하세요**
- 에이전트가 찾거나 수정해야 할 구체적인 타입, 함수 시그니처, 설정 형태를 **이름으로 지목하세요**
- 파일 경로를 **참조하지 마세요**. 낡습니다
- 줄 번호를 **참조하지 마세요**
- 현재 구현 구조가 그대로 유지될 것이라고 **가정하지 마세요**

### 절차가 아니라 행동

시스템이 **무엇을** 해야 하는지 서술하고, **어떻게** 구현하는지는 쓰지 마세요. 에이전트는 코드베이스를 새로 탐색하고 스스로 구현 결정을 내립니다.

- **좋음:** "`SkillConfig` 타입은 `CronExpression` 타입의 선택적 `schedule` 필드를 받아야 한다"
- **나쁨:** "src/types/skill.ts를 열고 42번째 줄에 schedule 필드를 추가하라"
- **좋음:** "사용자가 인자 없이 `/triage`를 실행하면 주의가 필요한 이슈의 요약을 보아야 한다"
- **나쁨:** "메인 핸들러 함수에 switch 문을 추가하라"

### 완전한 인수 기준

에이전트는 언제 끝나는지 알아야 합니다. 모든 에이전트 브리프에는 구체적이고 테스트 가능한 인수 기준이 있어야 합니다. 각 기준은 독립적으로 검증할 수 있어야 합니다.

- **좋음:** "`gh issue list --label needs-triage`를 실행하면 초기 분류를 거친 이슈가 반환된다"
- **나쁨:** "트리아지가 올바르게 동작해야 한다"

### 명시적인 범위 경계

범위 밖인 것을 명시하세요. 에이전트가 과잉으로 다듬거나 인접 기능에 대해 가정하는 것을 막아 줍니다.

## 템플릿

```markdown
## Agent Brief

**Category:** bug / enhancement
**Summary:** 무엇이 일어나야 하는지 한 줄 설명

**Current behavior:**
지금 무엇이 일어나는지 서술합니다.
버그라면 고장 난 동작입니다.
개선이라면 기능이 기반으로 삼는 현재 상태입니다.

**Desired behavior:**
에이전트의 작업이 완료된 뒤 무엇이 일어나야 하는지 서술합니다.
엣지 케이스와 에러 조건을 구체적으로 적습니다.

**Key interfaces:**
- `TypeName`: 무엇이 왜 바뀌어야 하는지
- `functionName()` 반환 타입: 현재 반환하는 것과 반환해야 하는 것
- 설정 형태: 필요한 새 설정 옵션

**Acceptance criteria:**
- [ ] 구체적이고 테스트 가능한 기준 1
- [ ] 구체적이고 테스트 가능한 기준 2
- [ ] 구체적이고 테스트 가능한 기준 3

**Out of scope:**
- 이 이슈에서 바꾸거나 다루지 말아야 할 것
- 관련 있어 보이지만 별개인 인접 기능
```

## 예시

### 좋은 에이전트 브리프 (버그)

```markdown
## Agent Brief

**Category:** bug
**Summary:** Skill description truncation drops mid-word, producing broken output

**Current behavior:**
When a skill description exceeds 1024 characters, it is truncated at exactly
1024 characters regardless of word boundaries. This produces descriptions
that end mid-word (e.g. "Use when the user wants to confi").

**Desired behavior:**
Truncation should break at the last word boundary before 1024 characters
and append "..." to indicate truncation.

**Key interfaces:**
- The `SkillMetadata` type's `description` field: no type change needed,
  but the validation/processing logic that populates it needs to respect
  word boundaries
- Any function that reads SKILL.md frontmatter and extracts the description

**Acceptance criteria:**
- [ ] Descriptions under 1024 chars are unchanged
- [ ] Descriptions over 1024 chars are truncated at the last word boundary
      before 1024 chars
- [ ] Truncated descriptions end with "..."
- [ ] The total length including "..." does not exceed 1024 chars

**Out of scope:**
- Changing the 1024 char limit itself
- Multi-line description support
```

### 좋은 에이전트 브리프 (개선)

```markdown
## Agent Brief

**Category:** enhancement
**Summary:** Add `.out-of-scope/` directory support for tracking rejected feature requests

**Current behavior:**
When a feature request is rejected, the issue is closed with a `wontfix` label
and a comment. There is no persistent record of the decision or reasoning.
Future similar requests require the maintainer to recall or search for the
prior discussion.

**Desired behavior:**
Rejected feature requests should be documented in `.out-of-scope/<concept>.md`
files that capture the decision, reasoning, and links to all issues that
requested the feature. When triaging new issues, these files should be
checked for matches.

**Key interfaces:**
- Markdown file format in `.out-of-scope/`: each file should have a
  `# Concept Name` heading, a `**Decision:**` line, a `**Reason:**` line,
  and a `**Prior requests:**` list with issue links
- The triage workflow should read all `.out-of-scope/*.md` files early
  and match incoming issues against them by concept similarity

**Acceptance criteria:**
- [ ] Closing a feature as wontfix creates/updates a file in `.out-of-scope/`
- [ ] The file includes the decision, reasoning, and link to the closed issue
- [ ] If a matching `.out-of-scope/` file already exists, the new issue is
      appended to its "Prior requests" list rather than creating a duplicate
- [ ] During triage, existing `.out-of-scope/` files are checked and surfaced
      when a new issue matches a prior rejection

**Out of scope:**
- Automated matching (human confirms the match)
- Reopening previously rejected features
- Bug reports (only enhancement rejections go to `.out-of-scope/`)
```

### 좋은 에이전트 브리프 (PR)

PR의 경우 "Current behavior"는 diff의 상태를 서술하며, 브리프는 에이전트에게 처음부터 만들지 말고 마무리하거나 고치라고 요청합니다.

```markdown
## Agent Brief

**Category:** enhancement
**Summary:** Finish the contributor's `--json` output flag for `triage list`

**Current behavior:**
The PR adds a `--json` flag that serializes the issue list to JSON. The happy
path works and the diff matches the project's command structure. Two gaps
remain: errors are still printed as human text (not JSON), and the new flag has
no test coverage.

**Desired behavior:**
With `--json`, all output (including errors) is well-formed JSON on stdout,
and the command's exit codes are unchanged. The existing human-readable output
is untouched when the flag is absent.

**Key interfaces:**
- The command's error path should emit `{ "error": string }` under `--json`
  instead of the plain-text error
- Reuse the existing serializer the PR already added; don't introduce a second

**Acceptance criteria:**
- [ ] `triage list --json` emits valid JSON for both success and error cases
- [ ] Exit codes match the non-JSON command
- [ ] A test covers the `--json` success output and one error case
- [ ] Default (non-JSON) output is byte-for-byte unchanged

**Out of scope:**
- Adding `--json` to any other command
- Changing the JSON shape of the success payload the PR already defined
```

### 나쁜 에이전트 브리프

```markdown
## Agent Brief

**Summary:** Fix the triage bug

**What to do:**
The triage thing is broken. Look at the main file and fix it.
The function around line 150 has the issue.

**Files to change:**
- src/triage/handler.ts (line 150)
- src/types.ts (line 42)
```

이것이 나쁜 이유:
- 범주 없음
- 모호한 설명 ("the triage thing is broken")
- 낡아 버릴 파일 경로와 줄 번호를 참조함
- 인수 기준 없음
- 범위 경계 없음
- 현재 동작과 원하는 동작에 대한 설명 없음
