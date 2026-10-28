---
name: git-guardrails-claude-code
description: 위험한 git 명령(push, reset --hard, clean, branch -D 등)이 실행되기 전에 차단하는 Claude Code 훅을 설정합니다. 사용자가 파괴적인 git 작업을 막고 싶을 때, git 안전 훅을 추가하고 싶을 때, Claude Code에서 git push/reset을 차단하고 싶을 때 사용합니다.
---

# Git 가드레일 설정

Claude가 위험한 git 명령을 실행하기 전에 가로채서 차단하는 PreToolUse 훅을 설정합니다.

## 차단되는 것

- `git push` (`--force`를 포함한 모든 변형)
- `git reset --hard`
- `git clean -f` / `git clean -fd`
- `git branch -D`
- `git checkout .` / `git restore .`

차단되면 Claude는 이 명령에 접근할 권한이 없다는 메시지를 봅니다.

## 단계

### 1. 범위 묻기

사용자에게 물으세요. **이 프로젝트에만**(`.claude/settings.json`) 설치할까요, **모든 프로젝트**(`~/.claude/settings.json`)에 설치할까요?

### 2. 훅 스크립트 복사

번들된 스크립트는 여기에 있습니다: [scripts/block-dangerous-git.sh](scripts/block-dangerous-git.sh)

범위에 따라 대상 위치로 복사하세요.

- **프로젝트**: `.claude/hooks/block-dangerous-git.sh`
- **전역**: `~/.claude/hooks/block-dangerous-git.sh`

`chmod +x`로 실행 가능하게 만드세요.

### 3. 설정에 훅 추가

알맞은 설정 파일에 추가하세요.

**프로젝트** (`.claude/settings.json`):

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "\"$CLAUDE_PROJECT_DIR\"/.claude/hooks/block-dangerous-git.sh"
          }
        ]
      }
    ]
  }
}
```

**전역** (`~/.claude/settings.json`):

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "~/.claude/hooks/block-dangerous-git.sh"
          }
        ]
      }
    ]
  }
}
```

설정 파일이 이미 있다면 기존 `hooks.PreToolUse` 배열에 훅을 병합하세요. 다른 설정을 덮어쓰지 마세요.

### 4. 커스터마이징 묻기

차단 목록에 패턴을 추가하거나 제거하고 싶은지 사용자에게 물으세요. 복사한 스크립트를 그에 맞게 편집하세요.

### 5. 검증

빠른 테스트를 실행하세요.

```bash
echo '{"tool_input":{"command":"git push origin main"}}' | <path-to-script>
```

종료 코드 2로 끝나고 stderr에 차단됨(BLOCKED) 메시지가 출력되어야 합니다.
