# 좋은 테스트와 나쁜 테스트

## 좋은 테스트

**통합 스타일**: 내부 부품을 모킹하지 않고 실제 인터페이스를 통해 테스트합니다.

```typescript
// 좋음: 관찰 가능한 동작을 테스트
test("user can checkout with valid cart", async () => {
  const cart = createCart();
  cart.add(product);
  const result = await checkout(cart, paymentMethod);
  expect(result.status).toBe("confirmed");
});
```

특징:

- 사용자나 호출자가 신경 쓰는 동작을 테스트한다
- 공개 API만 사용한다
- 내부 리팩터링에도 살아남는다
- HOW가 아니라 WHAT을 설명한다
- 테스트당 논리적 단언은 하나

## 나쁜 테스트

**구현 세부 사항 테스트**: 내부 구조에 결합되어 있습니다.

```typescript
// 나쁨: 구현 세부 사항을 테스트
test("checkout calls paymentService.process", async () => {
  const mockPayment = jest.mock(paymentService);
  await checkout(cart, payment);
  expect(mockPayment.process).toHaveBeenCalledWith(cart.total);
});
```

위험 신호:

- 내부 협력자를 모킹한다
- private 메서드를 테스트한다
- 호출 횟수나 순서를 단언한다
- 동작 변화 없이 리팩터링했는데 테스트가 깨진다
- 테스트 이름이 WHAT이 아니라 HOW를 설명한다
- 인터페이스 대신 외부 수단으로 검증한다

```typescript
// 나쁨: 인터페이스를 우회해서 검증
test("createUser saves to database", async () => {
  await createUser({ name: "Alice" });
  const row = await db.query("SELECT * FROM users WHERE name = ?", ["Alice"]);
  expect(row).toBeDefined();
});

// 좋음: 인터페이스를 통해 검증
test("createUser makes user retrievable", async () => {
  const user = await createUser({ name: "Alice" });
  const retrieved = await getUser(user.id);
  expect(retrieved.name).toBe("Alice");
});
```

**동어반복 테스트**: 기댓값이 구현을 그대로 되풀이하므로 구성상 테스트가 통과합니다.

```typescript
// 나쁨: 기댓값을 코드가 계산하는 방식 그대로 다시 계산
test("calculateTotal sums line items", () => {
  const items = [{ price: 10 }, { price: 5 }];
  const expected = items.reduce((sum, i) => sum + i.price, 0);
  expect(calculateTotal(items)).toBe(expected);
});

// 좋음: 기댓값이 독립적이고 알려진 리터럴
test("calculateTotal sums line items", () => {
  expect(calculateTotal([{ price: 10 }, { price: 5 }])).toBe(15);
});
```
