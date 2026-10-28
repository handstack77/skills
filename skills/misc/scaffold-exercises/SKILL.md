---
name: scaffold-exercises
description: 린트를 통과하는 섹션, 문제, 풀이, 설명으로 이루어진 실습 디렉터리 구조를 만듭니다. 사용자가 실습 뼈대를 만들거나, 실습 스텁을 만들거나, 새 강의 섹션을 설정하고 싶을 때 사용합니다.
---

# 실습 뼈대 만들기

`pnpm ai-hero-cli internal lint`를 통과하는 실습 디렉터리 구조를 만든 다음 `git commit`으로 커밋하세요.

## 디렉터리 이름 규칙

- **섹션**: `exercises/` 안의 `XX-section-name/` (예: `01-retrieval-skill-building`)
- **실습**: 섹션 안의 `XX.YY-exercise-name/` (예: `01.03-retrieval-with-bm25`)
- 섹션 번호 = `XX`, 실습 번호 = `XX.YY`
- 이름은 dash-case (소문자, 하이픈)

## 실습 변형

각 실습에는 다음 하위 폴더 중 적어도 하나가 필요합니다.

- `problem/` - TODO가 있는 학생 작업 공간
- `solution/` - 참고 구현
- `explainer/` - 개념 자료, TODO 없음

스텁을 만들 때는 계획에 달리 명시되어 있지 않은 한 `explainer/`를 기본으로 하세요.

## 필수 파일

각 하위 폴더(`problem/`, `solution/`, `explainer/`)에는 다음을 만족하는 `readme.md`가 필요합니다.

- **비어 있지 않아야** 합니다 (실제 내용이 있어야 하며, 제목 한 줄이라도 괜찮습니다)
- 깨진 링크가 없어야 합니다

스텁을 만들 때는 제목과 설명이 있는 최소한의 readme를 만드세요.

```md
# Exercise Title

Description here
```

하위 폴더에 코드가 있다면 `main.ts`(1줄 초과)도 필요합니다. 하지만 스텁에서는 readme만 있는 실습도 괜찮습니다.

## 워크플로

1. **계획 파싱** - 섹션 이름, 실습 이름, 변형 유형을 추출합니다
2. **디렉터리 만들기** - 각 경로에 `mkdir -p`
3. **스텁 readme 만들기** - 변형 폴더마다 제목이 있는 `readme.md` 하나
4. **린트 실행** - `pnpm ai-hero-cli internal lint`로 검증
5. **오류 수정** - 린트가 통과할 때까지 반복

## 린트 규칙 요약

린터(`pnpm ai-hero-cli internal lint`)는 다음을 검사합니다.

- 각 실습에 하위 폴더(`problem/`, `solution/`, `explainer/`)가 있다
- `problem/`, `explainer/`, `explainer.1/` 중 적어도 하나가 존재한다
- 기본 하위 폴더에 `readme.md`가 존재하고 비어 있지 않다
- `.gitkeep` 파일이 없다
- `speaker-notes.md` 파일이 없다
- readme에 깨진 링크가 없다
- readme에 `pnpm run exercise` 명령이 없다
- readme만 있는 경우가 아니라면 하위 폴더마다 `main.ts`가 필요하다

## 실습 옮기기/이름 바꾸기

실습의 번호를 다시 매기거나 옮길 때:

1. 디렉터리 이름을 바꿀 때는 `mv`가 아니라 `git mv`를 쓰세요. git 이력이 보존됩니다
2. 순서를 유지하도록 숫자 접두사를 갱신하세요
3. 옮긴 뒤 린트를 다시 실행하세요

예시:

```bash
git mv exercises/01-retrieval/01.03-embeddings exercises/01-retrieval/01.04-embeddings
```

## 예시: 계획에서 스텁 만들기

다음과 같은 계획이 주어졌을 때:

```
Section 05: Memory Skill Building
- 05.01 Introduction to Memory
- 05.02 Short-term Memory (explainer + problem + solution)
- 05.03 Long-term Memory
```

다음을 만드세요.

```bash
mkdir -p exercises/05-memory-skill-building/05.01-introduction-to-memory/explainer
mkdir -p exercises/05-memory-skill-building/05.02-short-term-memory/{explainer,problem,solution}
mkdir -p exercises/05-memory-skill-building/05.03-long-term-memory/explainer
```

그다음 readme 스텁을 만드세요.

```
exercises/05-memory-skill-building/05.01-introduction-to-memory/explainer/readme.md -> "# Introduction to Memory"
exercises/05-memory-skill-building/05.02-short-term-memory/explainer/readme.md -> "# Short-term Memory"
exercises/05-memory-skill-building/05.02-short-term-memory/problem/readme.md -> "# Short-term Memory"
exercises/05-memory-skill-building/05.02-short-term-memory/solution/readme.md -> "# Short-term Memory"
exercises/05-memory-skill-building/05.03-long-term-memory/explainer/readme.md -> "# Long-term Memory"
```
