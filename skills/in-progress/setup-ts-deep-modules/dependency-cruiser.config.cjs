// @ts-check
// dependency-cruiser용 깊은 모듈 강제.
//
// 패키지 루트 아래의 각 패키지는 깊은 모듈입니다. 작은 인터페이스 뒤에 많은
// 동작이 있습니다. 패키지의 공개 표면은 진입점, 곧 패키지 루트의 파일들입니다.
// 구현은 하위 폴더에 두며 비공개입니다(관례상 구현은 `lib/`, 테스트는 `tests/`
// 이지만 어떤 하위 폴더든 비공개입니다). 패키지는 작은 진입점 여럿(index.ts,
// client.ts, server.ts, …)을 노출할 수 있으며, 거대한 배럴 index 하나보다
// 그쪽을 선호하세요.
//
// 여기서 편집해야 할 것은 PACKAGES_ROOT 하나뿐입니다.

/** 패키지가 있는 곳. 패키지당 직계 자식 디렉터리 하나(평평하고 중첩 없음). */
const PACKAGES_ROOT = "src/packages";

// --- 파생된 패턴 (편집할 필요 없음) -----------------------------------------
const R = PACKAGES_ROOT;
/**
 * 패키지의 비공개 내부: 패키지 하위 폴더 안에 중첩된 모든 것.
 * 패키지의 루트 파일은 진입점이므로 여기서 매칭되지 않습니다.
 * 바깥에서 계속 import할 수 있습니다.
 */
const PACKAGE_INTERNALS = `^${R}/[^/]+/[^/]+/`;

/** @type {import('dependency-cruiser').IConfiguration} */
module.exports = {
  forbidden: [
    {
      name: "entrypoint-boundary-from-app",
      comment:
        "앱/루트 코드는 패키지의 진입점(루트 파일)은 import할 수 있지만, 하위 폴더 안의 것은 안 됩니다.",
      severity: "error",
      from: { pathNot: `^${R}/` }, // importer가 어떤 패키지 안에도 없음
      to: { path: PACKAGE_INTERNALS },
    },
    {
      name: "entrypoint-boundary-across-packages",
      comment:
        "패키지 자신의 파일들은 서로 자유롭게 import하지만, 다른 패키지에는 진입점을 통해서만 도달할 수 있고 내부에는 도달할 수 없습니다.",
      severity: "error",
      // importer가 패키지($1) 안에 있고, 테스트 파일이 아님
      from: { path: `^${R}/([^/]+)/`, pathNot: `^${R}/[^/]+/tests/` },
      to: {
        path: PACKAGE_INTERNALS,
        pathNot: `^${R}/$1/`, // 같은 패키지 → 패키지 내부의 자유
      },
    },
    {
      name: "tests-through-entrypoints",
      comment:
        "패키지의 테스트도 다른 모든 것과 마찬가지로 진입점을 통해 패키지를 실행합니다. 모든 패키지의 진입점과 자신의 tests/ 픽스처는 import할 수 있지만, 어떤 패키지의 내부도(자기 것도) 안 됩니다.",
      severity: "error",
      from: { path: `^${R}/([^/]+)/tests/` }, // 패키지 $1 안의 테스트 파일
      to: {
        path: PACKAGE_INTERNALS,
        pathNot: `^${R}/$1/tests/`, // 자신의 tests/ 픽스처 → 허용
      },
    },
    {
      name: "tests-folder-is-private",
      comment:
        "패키지의 tests/ 폴더는 테스트에서만 도달할 수 있습니다. 다른 어떤 것도 픽스처를 import할 수 없습니다.",
      severity: "error",
      from: { pathNot: `^${R}/[^/]+/tests/` }, // importer 자신이 테스트가 아님
      to: { path: `^${R}/[^/]+/tests/` },
    },
    {
      name: "no-circular",
      comment: "의존성 순환 없음. 패키지 밖의 순환을 허용하려면 `^${R}/`로 범위를 한정하세요.",
      severity: "error",
      from: {},
      to: { circular: true },
    },

    // --- 계층화 (선택, 기본은 꺼짐) --------------------------------------------
    // 인터페이스 숨기기는 import하는 방식(진입점을 통해서)을 통제합니다.
    // 계층화는 어떤 패키지가 어떤 패키지에 의존할 수 있는지를 통제합니다.
    // 여기에 직접 규칙을 추가하세요. 예:
    //
    // {
    //   name: "ui-may-not-depend-on-billing",
    //   severity: "error",
    //   from: { path: `^${R}/ui/` },
    //   to:   { path: `^${R}/billing/` },
    // },
  ],
  options: {
    doNotFollow: { path: "node_modules" },
    tsConfig: { fileName: "tsconfig.json" },
    enhancedResolveOptions: {
      extensions: [".ts", ".tsx", ".js", ".jsx", ".json"],
    },
  },
};
