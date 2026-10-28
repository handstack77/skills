# 범위 밖 지식 베이스

저장소의 `.out-of-scope/` 디렉터리는 기각된 기능 요청의 영속적인 기록을 저장합니다. 두 가지 목적이 있습니다.

1. **조직의 기억**: 기능이 왜 기각되었는지, 이슈가 닫혀도 근거가 사라지지 않도록
2. **중복 제거**: 이전에 기각된 것과 일치하는 새 이슈가 들어오면, 스킬이 다시 따지는 대신 이전 결정을 드러낼 수 있음

## 디렉터리 구조

```
.out-of-scope/
├── dark-mode.md
├── plugin-system.md
└── graphql-api.md
```

이슈당이 아니라 **개념**당 파일 하나입니다. 같은 것을 요청하는 여러 이슈는 파일 하나 아래로 묶입니다.

## 파일 형식

파일은 데이터베이스 항목보다는 짧은 설계 문서처럼, 느슨하고 읽기 쉬운 문체로 쓰세요. 처음 접하는 사람에게 근거가 분명하고 유용해지도록 문단, 코드 샘플, 예시를 사용하세요.

```markdown
# Dark Mode

This project does not support dark mode or user-facing theming.

## Why this is out of scope

The rendering pipeline assumes a single color palette defined in
`ThemeConfig`. Supporting multiple themes would require:

- A theme context provider wrapping the entire component tree
- Per-component theme-aware style resolution
- A persistence layer for user theme preferences

This is a significant architectural change that doesn't align with the
project's focus on content authoring. Theming is a concern for downstream
consumers who embed or redistribute the output.

```ts
// The current ThemeConfig interface is not designed for runtime switching:
interface ThemeConfig {
  colors: ColorPalette; // single palette, resolved at build time
  fonts: FontStack;
}
```

## Prior requests

- #42: "Add dark mode support"
- #87: "Night theme for accessibility"
- #134: "Dark theme option"
```

### 파일 이름 짓기

개념에 대해 짧고 서술적인 kebab-case 이름을 쓰세요. `dark-mode.md`, `plugin-system.md`, `graphql-api.md` 같은 식입니다. 디렉터리를 훑어보는 사람이 파일을 열지 않고도 무엇이 기각되었는지 이해할 만큼 알아볼 수 있는 이름이어야 합니다.

### 이유 쓰기

이유는 실질적이어야 합니다. "원하지 않는다"가 아니라 왜 그런지입니다. 좋은 이유는 다음을 참조합니다.

- 프로젝트의 범위나 철학 ("이 프로젝트는 X에 집중한다. 테마는 Downstream의 관심사다")
- 기술적 제약 ("이를 지원하려면 Y가 필요한데, 이는 우리의 Z 아키텍처와 충돌한다")
- 전략적 결정 ("B 대신 A를 쓰기로 했다. 왜냐하면...")

이유는 오래가야 합니다. 일시적인 사정("지금 너무 바쁘다")을 참조하지 마세요. 그것은 진짜 기각이 아니라 연기입니다.

## `.out-of-scope/`를 확인할 때

트리아지 중(1단계: 컨텍스트 모으기)에 `.out-of-scope/`의 모든 파일을 읽으세요. 새 이슈를 평가할 때:

- 요청이 기존 범위 밖 개념과 일치하는지 확인합니다
- 일치는 키워드가 아니라 개념의 유사성으로 판단합니다. "night theme"은 `dark-mode.md`와 일치합니다
- 일치하는 것이 있으면 메인테이너에게 드러냅니다. "이것은 `.out-of-scope/dark-mode.md`와 비슷합니다. 이전에 [이유] 때문에 기각했습니다. 여전히 같은 생각이신가요?"

메인테이너는 다음 중 하나를 할 수 있습니다.

- **확인**: 새 이슈를 기존 파일의 "Prior requests" 목록에 추가한 뒤 닫습니다
- **재고**: 범위 밖 파일을 삭제하거나 갱신하고, 이슈는 정상 트리아지를 진행합니다
- **불일치**: 이슈들이 관련은 있지만 별개이므로 정상 트리아지를 진행합니다

## `.out-of-scope/`에 쓸 때

**개선**(버그가 아님)이 `wontfix`로 *기각*될 때만입니다. 이는 이슈와 똑같이 개선 PR에도 적용됩니다. 기각된 PR도 여기에 기록해서, 같은 요청이 새 코드로 다시 오지 않게 합니다.

**이미 구현되어 있다**는 이유로 `wontfix`로 닫을 때는 여기에 쓰지 **마세요**. 그것은 기각된 기능이 아니라 만들어진 기능입니다. 기록하면 거짓 기각으로 중복 제거 검사를 오염시킵니다. 대신 닫는 댓글에서 기능이 이미 있는 곳을 가리키세요.

흐름:

1. 메인테이너가 기능 요청이 범위 밖이라고 결정합니다
2. 일치하는 `.out-of-scope/` 파일이 이미 있는지 확인합니다
3. 있으면: 새 이슈를 "Prior requests" 목록에 추가합니다
4. 없으면: 개념 이름, 결정, 이유, 첫 번째 이전 요청을 담은 새 파일을 만듭니다
5. 이슈에 결정을 설명하고 `.out-of-scope/` 파일을 언급하는 댓글을 게시합니다
6. `wontfix` 라벨을 붙여 이슈를 닫습니다

## 범위 밖 파일 갱신하거나 제거하기

메인테이너가 이전에 기각한 개념에 대해 마음을 바꾸면:

- `.out-of-scope/` 파일을 삭제합니다
- 스킬이 오래된 이슈를 다시 열 필요는 없습니다. 그것은 역사적 기록입니다
- 재고의 계기가 된 새 이슈는 정상 트리아지를 진행합니다
