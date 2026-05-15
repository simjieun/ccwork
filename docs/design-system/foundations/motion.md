---
name: Motion
description: 검증 필요 — 디자이너 컨펌 대기 중인 stub
type: foundation
status: 검증필요
figma-node: TBD
last-verified: 2026-05-14
verified-by: simjieun
---

# Motion

> **검증 필요** — Figma 원본은 정적 카탈로그이므로 트랜지션 토큰을 추출할 수 없다. 인터랙션 스펙(prefers-reduced-motion 대응 포함)은 디자이너 합의 후 등재한다. 임시 가이드는 [accessibility.md](../guidelines/accessibility.md)의 AC-M1/M2를 따른다.

## 확인이 필요한 항목

- duration 토큰 체계(예: motion.duration.instant / fast / normal / slow).
- easing 함수(예: motion.easing.standard / accelerate / decelerate).
- 상호작용별 권장 duration(hover/focus는 100ms, 페이지 전환은 200ms 등).
- 컴포넌트별 트랜지션 적용 속성 화이트리스트(transform/opacity만 등).

## 임시 가이드 (확정 전까지)

- 즉각 피드백(hover/focus 색 전환)은 100ms 내외로 짧게.
- 자동 반복되는 강조 애니메이션은 정보 전달 용도로 사용 금지.
- `prefers-reduced-motion: reduce` 시 비필수 트랜지션 비활성화(**must**).
- raw duration 값을 컴포넌트 코드에 박지 않는다 — 토큰 확정 시 일괄 교체 가능하도록 변수에 모은다(**should**).
