---
"junchul-skills": patch
---

`handoff`가 이제 OS 임시 디렉터리가 어디인지(`$TMPDIR`, 없으면 `/tmp`, Windows에서는 `%TEMP%`) 밝혀서 에이전트가 더 이상 추측하지 않습니다 (#272).
