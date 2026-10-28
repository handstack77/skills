# CLI 내장 명령과 스킬 이름의 충돌

Claude Code와 Codex CLI에서 내장 명령과 같은 이름을 쓴다는 이유만으로 공유 스킬 이름을 일괄 변경하지 않습니다. 로컬 스킬을 선택할 때 실제로 로드되는 `SKILL.md` 경로를 확인하세요.

Claude Code는 `/junchul-skills:name`, Codex CLI는 `$junchul-skills:name`으로 설치한 스킬을 명시합니다. Codex CLI의 `/skills` 목록에서도 선택할 수 있습니다.

개인적으로 다른 이름이 필요하면 원본 스킬 폴더와 `SKILL.md`의 `name`을 함께 바꾸고, 관련 문서와 호출 지점, 두 매니페스트를 갱신한 뒤 [설정 안내](../.agents/install-block.md)에 따라 플러그인을 갱신하세요.
