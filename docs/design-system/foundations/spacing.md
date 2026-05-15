---
name: Spacing
description: 2~24px 스케일. space.11/13은 버튼 전용 토큰
type: foundation
status: verified
figma-node: '1:2'
last-verified: 2026-05-14
verified-by: simjieun
---

# Spacing

| 토큰       | 값     |
| ---------- | ------ |
| `space.2`  | `2px`  |
| `space.4`  | `4px`  |
| `space.6`  | `6px`  |
| `space.8`  | `8px`  |
| `space.10` | `10px` |
| `space.11` | `11px` |
| `space.12` | `12px` |
| `space.13` | `13px` |
| `space.14` | `14px` |
| `space.16` | `16px` |
| `space.20` | `20px` |
| `space.24` | `24px` |

## 사용 규칙

- padding/gap/margin은 위 토큰 값만 사용한다(**must**).
- 컴포넌트 내부 간격은 `space.4` ~ `space.16`을 주로 사용한다.
- `space.11` / `space.13`은 버튼 50 Large·44 Medium의 세로 패딩 전용으로만 사용한다(다른 컴포넌트로 확산 금지, **must**).
- `space.2`는 아이콘과 텍스트 사이의 미세 정렬에만 한정한다(예: 텍스트 링크 with icon).
- 컴포넌트 사이 간격은 부모 레이아웃에서 정의한다 — 자식이 외부 margin을 가져가지 않는다(**should**).
