---
name: Button Variants
description: 색(Primary/Primary Light/Gray/Black/Ghost) × 형상(Filled/Outlined) 조합 정의
type: component-detail
status: verified
figma-node: '1:2'
last-verified: 2026-05-14
verified-by: simjieun
---

# Button — Variants

색(Color)과 형상(Shape)을 2축으로 조합한다.

## 색

| Color           | 배경                               | 보더 | Label color                  | 용도                                     |
| --------------- | ---------------------------------- | ---- | ---------------------------- | ---------------------------------------- |
| `Primary`       | `color.bg.brand` (#D72E36)         | —    | `color.text.inverse`         | 페이지의 주요 행동 1개                   |
| `Primary Light` | `color.brand.primaryLow` (#FFD7D9) | —    | `color.text.brand` (#D72E36) | Primary와 같은 의도지만 위계가 약한 행동 |
| `Gray`          | `color.bg.muted` (#F6F6F6)         | —    | `color.text.primary`         | 보조 행동                                |
| `Black`         | `color.text.primary` (#181818)     | —    | `color.text.inverse`         | 강조가 필요한 보조 행동                  |
| `Ghost`         | transparent                        | —    | `color.text.primary`         | 위계가 가장 낮은 행동(취소 등)           |

## 형상

| Shape              | 설명                       | 사용 가능 색                           |
| ------------------ | -------------------------- | -------------------------------------- |
| `Filled` (default) | 배경 채움                  | Primary / Primary Light / Gray / Black |
| `Outlined`         | 보더 1px, 배경 transparent | Primary / Gray / Black                 |
| `Ghost`            | 배경·보더 없음             | (색 축의 Ghost 변형으로만 사용)        |

`Outlined` 보더 색은 같은 컬러 토큰을 사용한다 — 예: `Black Outlined`는 `color.border.strong` (#181818) 1px.

## 위계 규칙

> 한 화면에 `Primary`는 **must** 1개. 2개 이상이면 위계가 깨진다. 다른 강조 행동이 필요하면 `Black` 또는 `Primary Light`로 위계를 분리한다.
