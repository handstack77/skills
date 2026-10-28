# HTML 보고서 형식

아키텍처 리뷰는 OS 임시 디렉터리의 독립적인 HTML 파일 하나로 렌더링됩니다. Tailwind와 Mermaid는 둘 다 CDN에서 가져옵니다. Mermaid는 그래프 모양의 다이어그램을 확실하게 처리하고, 직접 만든 div와 인라인 SVG는 더 에디토리얼한 시각 자료(질량 다이어그램, 단면도)를 처리합니다. 둘을 섞으세요. 모든 것을 Mermaid에 기대면 평범해 보이기 시작합니다.

## 뼈대

```html
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <title>Architecture review for {{repo name}}</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script type="module">
      import mermaid from "https://cdn.jsdelivr.net/npm/mermaid@11/dist/mermaid.esm.min.mjs";
      mermaid.initialize({ startOnLoad: true, theme: "neutral", securityLevel: "loose" });
    </script>
    <style>
      /* Tailwind가 깔끔하게 다루지 못하는 것을 위한 작은 커스텀 레이어:
         점선 이음매 선, 손으로 그린 느낌의 화살촉 등. */
      .seam { stroke-dasharray: 4 4; }
      .leak { stroke: #dc2626; }
      .deep { background: linear-gradient(135deg, #0f172a, #1e293b); }
    </style>
  </head>
  <body class="bg-stone-50 text-slate-900 font-sans">
    <main class="max-w-5xl mx-auto px-6 py-12 space-y-12">
      <header>...</header>
      <section id="candidates" class="space-y-10">...</section>
      <section id="top-recommendation">...</section>
    </main>
  </body>
</html>
```

## 헤더

저장소 이름, 날짜, 그리고 간결한 범례: 실선 상자 = 모듈, 점선 = 이음매, 빨간 화살표 = 누수, 굵은 어두운 상자 = 깊은 모듈. 소개 문단은 없습니다. 바로 후보로 들어갑니다.

## 후보 카드

다이어그램이 무게를 짊어집니다. 산문은 드물고 평이하며, 격식 없이 (`/codebase-design` 스킬의) 용어집 용어를 씁니다.

후보마다 `<article>` 하나입니다.

- **Title**: 짧게, 깊게 만들기를 이름 붙입니다(예: "Collapse the Order intake pipeline").
- **Badge row**: 추천 강도(`Strong` = 에메랄드, `Worth exploring` = 앰버, `Speculative` = 슬레이트), 그리고 의존성 범주 태그(`in-process`, `local-substitutable`, `ports & adapters`, `mock`).
- **Files**: 고정폭 목록, `font-mono text-sm`.
- **Before / After diagram**: 중심 요소입니다. 두 열을 나란히. 아래 패턴을 보세요.
- **Problem**: 한 문장. 무엇이 아픈가.
- **Solution**: 한 문장. 무엇이 바뀌는가.
- **Wins**: 불릿, 각각 6단어 이하. 예: "Tests hit one interface", "Pricing logic stops leaking", "Delete 4 shallow wrappers".
- **ADR callout** (해당되면): 앰버 색조 상자 안의 한 줄.

설명 문단은 없습니다. 다이어그램을 이해하는 데 문단이 필요하다면 다이어그램을 다시 그리세요.

## 다이어그램 패턴

후보에 맞는 패턴을 고르세요. 섞어 쓰세요. 모든 다이어그램이 똑같아 보이게 하지 마세요. 다양성도 핵심의 일부입니다.

### Mermaid 그래프 (의존성 / 호출 흐름의 주력)

요점이 "X가 Y를 호출하고 Y가 Z를 호출하는데, 이 엉망을 보라"일 때 Mermaid `flowchart`나 `graph`를 쓰세요. 낙하산처럼 느껴지지 않게 Tailwind로 꾸민 카드로 감싸세요. classDef로 누수 엣지는 빨갛게, 깊은 모듈은 어둡게 칠하세요. 시퀀스 다이어그램은 "이전: 왕복 6회, 이후: 1회"에 잘 맞습니다.

```html
<div class="rounded-lg border border-slate-200 bg-white p-4">
  <pre class="mermaid">
    flowchart LR
      A[OrderHandler] --> B[OrderValidator]
      B --> C[OrderRepo]
      C -.leak.-> D[PricingClient]
      classDef leak stroke:#dc2626,stroke-width:2px;
      class C,D leak
  </pre>
</div>
```

### 직접 만든 상자와 화살표 (Mermaid의 레이아웃과 싸워야 할 때)

테두리와 레이블이 있는 `<div>`로 모듈을 만듭니다. 화살표는 상대 위치 컨테이너 위에 절대 위치로 놓은 인라인 SVG `<line>`이나 `<path>` 요소입니다. "이후" 다이어그램이 내부를 회색으로 흐리게 한 굵은 테두리의 깊은 모듈 하나처럼 느껴지길 원할 때 쓰세요. Mermaid는 그 무게감을 제대로 렌더링하지 못합니다.

### 단면도 (층층이 얕은 구조에 좋음)

수평 띠(`h-12 border-l-4`)를 쌓아 호출이 통과하는 층을 보여 줍니다. 이전: 아무것도 안 하는 얇은 층 6개. 이후: 통합된 책임을 레이블로 붙인 굵은 띠 1개.

### 질량 다이어그램 ("인터페이스가 구현만큼 넓다"에 좋음)

모듈마다 직사각형 둘: 인터페이스 표면적용과 구현용. 이전: 인터페이스 직사각형이 구현 직사각형만큼 높습니다(얕음). 이후: 인터페이스 직사각형은 짧고 구현 직사각형은 높습니다(깊음).

### 호출 그래프 붕괴

이전: 중첩된 상자로 렌더링한 함수 호출 트리. 이후: 같은 트리를 상자 하나로 접고, 이제 내부가 된 호출을 그 안에 흐리게 보여 줍니다.

## 스타일 지침

- 기업 대시보드가 아니라 에디토리얼 쪽으로. 여백을 넉넉하게. 제목에는 세리프를 선택적으로 (`font-serif`가 stone/slate와 잘 어울립니다).
- 색은 아껴 쓰세요. 강조색 하나(에메랄드 또는 인디고)에, 누수에는 빨강, 경고에는 앰버.
- 이전/이후가 스크롤 없이 나란히 편안하게 놓이도록 다이어그램 높이는 약 320px로 유지하세요.
- 다이어그램 안의 모듈 레이블에는 `text-xs uppercase tracking-wider`를 써서 UI가 아니라 도식으로 읽히게 하세요.
- 스크립트는 Tailwind CDN과 Mermaid ESM import뿐입니다. 보고서는 그 외에는 정적입니다. 앱 코드도, Mermaid 자체 렌더링 이상의 인터랙션도 없습니다.

## Top recommendation 섹션

더 큰 카드 하나. 후보 이름, 이유 한 문장, 해당 카드로 가는 앵커 링크. 그게 전부입니다.

## 어조

쉬운 영어로 간결하게 쓰되, 아키텍처의 명사와 동사는 `/codebase-design` 스킬에서 곧바로 가져옵니다. 간결함이 어휘를 벗어나는 핑계가 되어서는 안 됩니다.

**정확히 이것을 쓰세요:** module, interface, implementation, depth, deep, shallow, seam, adapter, leverage, locality.

**절대 바꿔 쓰지 마세요:** component, service, unit (module 대신) · API, signature (interface 대신) · boundary (seam 대신) · layer, wrapper (module을 뜻할 때 module 대신).

**스타일에 맞는 표현:**

- "Order intake module is shallow: interface nearly matches the implementation."
- "Pricing leaks across the seam."
- "Deepen: one interface, one place to test."
- "Two adapters justify the seam: HTTP in prod, in-memory in tests."

**Wins 불릿**은 얻는 것을 용어집 용어로 이름 붙입니다. *"locality: bugs concentrate in one module"*, *"leverage: one interface, N call sites"*, *"interface shrinks; implementation absorbs the wrappers"*. *"easier to maintain"*이나 *"cleaner code"*는 쓰지 마세요. 그런 용어는 용어집에 없고 자리를 얻을 자격이 없습니다.

얼버무리기도, 서두 늘어놓기도, "it's worth noting that…"도 없습니다. 문장이 불릿이 될 수 있다면 불릿으로 만드세요. 불릿을 잘라 낼 수 있다면 잘라 내세요. 용어가 `/codebase-design` 용어집에 없다면 새 용어를 만들기 전에 용어집에 있는 것을 먼저 찾으세요.
