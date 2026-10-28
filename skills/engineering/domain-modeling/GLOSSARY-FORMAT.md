# GLOSSARY.md 형식

## 구조

```md
# {컨텍스트 이름}

{이 컨텍스트가 무엇이고 왜 존재하는지 한두 문장으로 설명.}

## Language

**Order**:
{용어에 대한 한두 문장 설명}
_Avoid_: Purchase, transaction

**Invoice**:
배송 후 고객에게 보내는 지불 요청.
_Avoid_: Bill, payment request

**Customer**:
주문을 하는 사람 또는 조직.
_Avoid_: Client, buyer, account
```

## 규칙

- **단호하게 정하세요.** 같은 개념에 단어가 여러 개 있으면 가장 좋은 것을 하나 고르고 나머지는 `_Avoid_` 아래에 나열하세요.
- **정의를 간결하게 유지하세요.** 최대 한두 문장입니다. 그것이 무엇을 하는지가 아니라 무엇*인지*를 정의하세요.
- **이 프로젝트의 컨텍스트에 고유한 용어만 넣으세요.** 일반적인 프로그래밍 개념(타임아웃, 에러 유형, 유틸리티 패턴)은 프로젝트에서 아무리 많이 쓰더라도 넣지 않습니다. 용어를 추가하기 전에 물어보세요. 이것은 이 컨텍스트에만 있는 개념인가, 일반적인 프로그래밍 개념인가? 전자만 들어갑니다.
- **자연스러운 묶음이 생기면 소제목으로 그룹화하세요.** 모든 용어가 하나의 응집된 영역에 속한다면 평평한 목록도 괜찮습니다.

## 단일 컨텍스트 대 다중 컨텍스트 저장소

**단일 컨텍스트(대부분의 저장소):** 저장소 루트에 `GLOSSARY.md` 하나.

**다중 컨텍스트:** 저장소 루트의 `GLOSSARY-MAP.md`가 컨텍스트 목록, 위치, 서로의 관계를 나열합니다.

```md
# Glossary Map

## Contexts

- [Ordering](./src/ordering/GLOSSARY.md): 고객 주문을 접수하고 추적
- [Billing](./src/billing/GLOSSARY.md): 인보이스를 생성하고 결제를 처리
- [Fulfillment](./src/fulfillment/GLOSSARY.md): 창고 피킹과 배송을 관리

## Relationships

- **Ordering → Fulfillment**: Ordering이 `OrderPlaced` 이벤트를 발행하고, Fulfillment가 이를 소비해 피킹을 시작
- **Fulfillment → Billing**: Fulfillment가 `ShipmentDispatched` 이벤트를 발행하고, Billing이 이를 소비해 인보이스를 생성
- **Ordering ↔ Billing**: `CustomerId`와 `Money`의 공유 타입
```

스킬은 어떤 구조가 적용되는지 추론합니다.

- `GLOSSARY-MAP.md`가 있으면 그것을 읽어 컨텍스트를 찾는다
- 루트 `GLOSSARY.md`만 있으면 단일 컨텍스트
- 둘 다 없으면 첫 용어가 정리될 때 루트 `GLOSSARY.md`를 만든다

컨텍스트가 여러 개일 때는 현재 주제가 어느 것과 관련되는지 추론하세요. 불분명하면 물어보세요.
