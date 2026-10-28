---
name: setup-pre-commit
description: 현재 저장소에 lint-staged(Prettier), 타입 검사, 테스트를 실행하는 Husky pre-commit 훅을 설정합니다. 사용자가 pre-commit 훅을 추가하거나, Husky를 설정하거나, lint-staged를 구성하거나, 커밋 시점의 포매팅/타입 검사/테스트를 추가하고 싶을 때 사용합니다.
---

# Pre-Commit 훅 설정

## 설정되는 것

- **Husky** pre-commit 훅
- 스테이징된 모든 파일에 Prettier를 실행하는 **lint-staged**
- **Prettier** 설정 (없는 경우)
- pre-commit 훅 안의 **typecheck**와 **test** 스크립트

## 단계

### 1. 패키지 매니저 감지

`package-lock.json`(npm), `pnpm-lock.yaml`(pnpm), `yarn.lock`(yarn), `bun.lockb`(bun)을 확인하세요. 있는 것을 쓰세요. 불분명하면 npm을 기본으로 하세요.

### 2. 의존성 설치

devDependencies로 설치하세요.

```
husky lint-staged prettier
```

### 3. Husky 초기화

```bash
npx husky init
```

`.husky/` 디렉터리를 만들고 package.json에 `prepare: "husky"`를 추가합니다.

### 4. `.husky/pre-commit` 만들기

이 파일을 쓰세요 (Husky v9+에서는 shebang이 필요 없습니다).

```
npx lint-staged
npm run typecheck
npm run test
```

**조정**: `npm`을 감지한 패키지 매니저로 바꾸세요. 저장소의 package.json에 `typecheck`나 `test` 스크립트가 없다면 해당 줄을 생략하고 사용자에게 알리세요.

### 5. `.lintstagedrc` 만들기

```json
{
  "*": "prettier --ignore-unknown --write"
}
```

### 6. `.prettierrc` 만들기 (없는 경우)

Prettier 설정이 없을 때만 만드세요. 다음 기본값을 쓰세요.

```json
{
  "useTabs": false,
  "tabWidth": 2,
  "printWidth": 80,
  "singleQuote": false,
  "trailingComma": "es5",
  "semi": true,
  "arrowParens": "always"
}
```

### 7. 검증

- [ ] `.husky/pre-commit`이 존재하고 실행 가능하다
- [ ] `.lintstagedrc`가 존재한다
- [ ] package.json의 `prepare` 스크립트가 `"husky"`이다
- [ ] `prettier` 설정이 존재한다
- [ ] `npx lint-staged`를 실행해 동작을 확인한다

### 8. 커밋

변경되거나 만들어진 모든 파일을 스테이징하고 다음 메시지로 커밋하세요: `Add pre-commit hooks (husky + lint-staged + prettier)`

새 pre-commit 훅을 거치게 되므로 모든 것이 동작하는지 확인하는 좋은 스모크 테스트입니다.

## 참고

- Husky v9+는 훅 파일에 shebang이 필요 없습니다
- `prettier --ignore-unknown`은 Prettier가 파싱할 수 없는 파일(이미지 등)을 건너뜁니다
- pre-commit은 lint-staged를 먼저(빠르고, 스테이징된 것만) 실행한 뒤 전체 타입 검사와 테스트를 실행합니다
