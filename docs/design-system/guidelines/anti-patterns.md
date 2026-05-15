---
name: Anti-patterns
description: 시스템 레벨 원칙·이유 — 머지 전 체크박스는 qa-checklist.md
type: guideline
status: verified
last-verified: 2026-05-14
verified-by: simjieun
---

# Anti-patterns — 원칙과 이유

본 문서는 **원칙**과 **왜 그래야 하는지(이유)**, **가장 흔한 위반 예시**만 다룬다.
체크박스 형태의 점검은 [`qa-checklist.md`](./qa-checklist.md)가 단일 출처다.

## 1. 토큰 사용

- **원칙**: 컴포넌트는 semantic alias(`color.text.*`, `color.bg.*`, `text.*`, `space.*`, `radius.*`)만 참조한다. palette 직접 참조와 raw 값은 금지.
- **이유**: palette가 바뀌면 모든 컴포넌트가 영향을 받아 변경 폭발이 생긴다. semantic 계층이 의미를 고정해 변경을 흡수한다.
- **대표 위반**:
  - `className="bg-[#ff0044]"` (Tailwind 임의값)
  - 컴포넌트가 `color.gray.100`을 직접 참조
  - 시각만 비슷한 색을 골라 시맨틱이 다른 토큰을 재활용

## 2. 컴포넌트 상태

- **원칙**: 인터랙티브 컴포넌트는 최소 5상태(`Enabled` / `hover` / `focus-visible` / `Pressed` / `Disabled`)를 만족한다.
- **이유**: Figma 정적 변형(Enabled/Pressed/Disabled 3개)은 web 인터랙션을 모두 표현하지 못한다. `hover` / `focus-visible` 누락 시 마우스 사용자는 통과해도 키보드 사용자가 막힌다.
- **대표 위반**:
  - `hover`만 있고 `focus-visible` 없음
  - `Disabled`를 `opacity: 0.5`만으로 처리하고 `aria-disabled` 누락

## 3. 접근성

- **원칙**: 시각 + 보조 기술 양쪽 채널로 모든 정보를 전달한다.
- **이유**: 단일 채널 의존은 사용자 집단을 배제한다.
- **대표 위반**:
  - `outline: none`만 적용해 포커스 표식을 제거
  - 색만으로 의미 차이를 전달(에러를 빨간 보더로만 표시 등)
  - 24×24 미만의 클릭 타깃

## 4. 레이아웃·간격

- **원칙**: 컴포넌트 외부 여백은 부모 레이아웃이 결정한다. radius·spacing은 토큰만.
- **이유**: 자식이 외부 margin을 가져가면 재사용 시 의도치 않은 간격이 생기고, raw px·임의 radius는 토큰 일괄 변경을 깬다.
- **대표 위반**:
  - 자식 컴포넌트에 `mb-4` 같은 외부 margin 박기
  - 한 화면에서 radius 토큰 3종 이상 혼합
  - 시각 보정을 위해 `space.2`(2px)를 일반 간격으로 남용

## 5. 모션

- **원칙**: `prefers-reduced-motion: reduce`를 항상 존중한다. 의미 없는 모션은 추가하지 않는다.
- **이유**: 모션 민감성 사용자에게 멀미·발작 트리거가 될 수 있고, 무의미한 모션은 체감 지연만 늘린다.
- **대표 위반**:
  - 페이지 전환에 1초 이상 모션
  - 자동 반복 강조 애니메이션을 정보 전달 용도로 사용
- **주의**: Motion 토큰은 시스템에 미정의(검증 필요) — 임시 가이드는 [`accessibility.md`](./accessibility.md) AC-M1/M2.

## 6. 카피·라벨

- **원칙**: 행동은 동사로 단정. 같은 행동에는 같은 단어.
- **이유**: 라벨 분기(`Save` ↔ `Keep`)는 사용자가 같은 행동인지 다시 학습하게 만든다.
- **대표 위반**:
  - `Submit`, `OK`, `Click here` 같은 모호한 라벨
  - 에러 메시지에 다음 행동 안내가 없음

## 7. 코드 구현 (이 프로젝트)

- **원칙**: named export + `interface XxxProps` 인라인 정의 + `on*` / `handle*` 네이밍.
- **이유**: 이 프로젝트의 단일 일관성 패턴 — 혼용은 리뷰·검색·자동완성을 모두 깬다.
- **대표 위반**:
  - default export 도입
  - prop 타입을 별도 파일로 분리
  - 컴포넌트 안에 인라인 `style={{}}` 추가(기존 잔존분은 정리 대상)
