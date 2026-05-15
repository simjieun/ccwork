---
name: Radius
description: radius.sm(6) / radius.md(8) — 2단계만
type: foundation
status: verified
figma-node: '1:2'
last-verified: 2026-05-14
verified-by: simjieun
---

# Radius

| 토큰        | 값    | 용도                                       |
| ----------- | ----- | ------------------------------------------ |
| `radius.sm` | `6px` | 32 Small 버튼, 작은 라벨 박스              |
| `radius.md` | `8px` | 버튼(44/50/56), 인풋, Tip/Description 라벨 |

> 더 큰 radius(알약형, 모달 등)는 현재 검토한 컴포넌트 군에서는 사용되지 않는다. 필요 시 토큰을 추가한다.

## 사용 규칙

- 같은 컴포넌트 군 내에서 radius 토큰을 섞지 않는다(**must**) — 단, 버튼의 32 Small(`radius.sm`)과 그 외 사이즈(`radius.md`)는 의도된 차이이므로 예외.
- 토큰에 없는 값을 컴포넌트 안에 직접 박지 않는다(**must**).
