# 언제 모킹할까

**시스템 경계**에서만 모킹하세요.

- 외부 API (결제, 이메일 등)
- 데이터베이스 (경우에 따라 다름. 테스트 DB를 선호)
- 시간/무작위성
- 파일 시스템 (경우에 따라 다름)

모킹하지 말아야 할 것:

- 직접 만든 클래스/모듈
- 내부 협력자
- 직접 통제하는 모든 것

## 모킹하기 쉽게 설계하기

시스템 경계에서는 모킹하기 쉬운 인터페이스를 설계하세요.

**1. 의존성 주입을 사용하세요**

외부 의존성을 내부에서 만들지 말고 밖에서 넘겨주세요.

```typescript
// 모킹하기 쉬움
function processPayment(order, paymentClient) {
  return paymentClient.charge(order.total);
}

// 모킹하기 어려움
function processPayment(order) {
  const client = new StripeClient(process.env.STRIPE_KEY);
  return client.charge(order.total);
}
```

**2. 범용 fetcher보다 SDK 스타일 인터페이스를 선호하세요**

조건 로직이 든 범용 함수 하나 대신, 외부 연산마다 구체적인 함수를 만드세요.

```typescript
// 좋음: 각 함수를 독립적으로 모킹할 수 있음
const api = {
  getUser: (id) => fetch(`/users/${id}`),
  getOrders: (userId) => fetch(`/users/${userId}/orders`),
  createOrder: (data) => fetch('/orders', { method: 'POST', body: data }),
};

// 나쁨: 모킹하려면 목 안에 조건 로직이 필요
const api = {
  fetch: (endpoint, options) => fetch(endpoint, options),
};
```

SDK 방식의 의미:
- 각 목이 하나의 구체적인 형태를 반환한다
- 테스트 설정에 조건 로직이 없다
- 테스트가 어떤 엔드포인트를 실행하는지 보기 쉽다
- 엔드포인트별 타입 안전성
