# `misc/` 스킬의 변경

`skills/misc/` 아래의 스킬(`git-guardrails-claude-code`, `migrate-to-shoehorn`, `scaffold-exercises`, `setup-pre-commit`, 그리고 앞으로 거기에 들어오는 모든 것)은 동결되어 있습니다. 이들에 대한 버그 리포트, 기능 요청, PR은 닫힙니다.

## 범위 밖인 이유

`misc/`는 제가 갖고는 있지만 거의 쓰지 않는 스킬이 가는 곳입니다. 홍보하지 않습니다. 기본 플러그인 설치 대상에서 제외되고, 문서 페이지가 없으며, 제가 매일 돌리지도 않으므로 수정이 옳은지 알 수 없고 그것이 다른 것을 깨뜨릴 때 알아차릴 수도 없습니다. 이들을 홍보하는 스킬과 같은 기준으로 유지하려면 쓰임새는 훨씬 적은데 홍보하는 스킬과 같은 비용이 듭니다.

일부 사람들에게는 그대로도 여전히 동작하기 때문에 유지보수되지 않은 채 저장소에 남아 있습니다. 필요한 경우 원본 파일을 검토하고 개인 수정 사항을 관리하세요. 기본 플러그인에는 포함하지 않습니다.

나중에 `misc/` 스킬이 `engineering/`이나 `productivity/`로 다시 홍보되면, 그 시점부터 다시 범위 안에 들어옵니다.

## 이전 요청

- #14: "Potential typo in setup-pre-commit/SKILL.md"
- #301: "`block-dangerous-git.sh` is bypassed by any git global option (e.g. `git -C <dir> push`)"
- #465: "git-guardrails-claude-code documentation is missing benefits over built in Claude code deny rules"
- #898: "git-guardrails-claude-code: hook fails open without jq and misses common git spellings"
