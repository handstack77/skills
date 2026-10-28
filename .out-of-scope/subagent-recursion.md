# 서브에이전트가 스킬로 재귀하는 것에 대한 가드

스킬은 서브에이전트가 스킬을 재귀적으로 호출하거나 중첩된 에이전트를 띄우는 것(`/code-review` 서브에이전트가 `/code-review`를 다시 호출하거나, `/research` 에이전트가 다른 에이전트를 띄우는 것)에 대한 가드를 추가하지 않습니다. 말단 에이전트 지시, 깊이 제한, "이 스킬을 호출하지 마라" 줄을 추가해 달라는 요청은 범위 밖입니다.

## 범위 밖인 이유

무한 서브에이전트 루프를 막는 것은 스킬이 아니라 하니스의 책임이어야 합니다. 서브에이전트가 도달할 수 있는 도구와 스킬, 중첩이 얼마나 깊어질 수 있는지는 하니스가 정하므로, 거기서 정한 제한은 모든 스킬에 한꺼번에 적용됩니다. 한 스킬의 산문에 쓴 가드는 그 스킬만 다루고, 실행할 때마다 토큰을 쓰며, 여전히 모델이 따르기로 선택하는 것에 의존합니다.

서브에이전트가 무한히 재귀하거나 퍼진다면 하니스에 보고하세요.

## 이전 요청

- #530: "research skill: spawned background agent can recursively re-spawn another agent (uncontrolled nesting)"
- #573: "code-review sub-agents recursively invoke /code-review and fan out" (PR #1186, "code-review: make the Standards and Spec sub-agents leaf reviewers", closed)
