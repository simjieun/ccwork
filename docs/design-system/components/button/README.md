---
name: Button
description: 시스템 최빈 컴포넌트 — 색·형상·사이즈·상태 4축. Intent + Anatomy + 토큰 요약
type: component
status: verified
figma-node: '1:2'
last-verified: 2026-05-14
verified-by: simjieun
---

# Button

시스템에서 가장 빈도가 높은 컴포넌트. 색·형상·사이즈·상태의 4축으로 정의되며, 한 화면에서 위계가 흔들리지 않도록 일관성 우선.

## 의도 (Design intent)

사용자의 행동을 단정적으로 유도하는 단일 액션 트리거.

## Anatomy

```
┌──────────────────────────────┐
│  [Icon?]  Label  [Icon?]     │
└──────────────────────────────┘
   ▲       ▲       ▲
   leading label  trailing
```

- **Container**: 배경(또는 보더) + radius. 그림자는 사용하지 않는다.
- **Label**: 행동 동사 — 필수.
- **Leading / trailing icon**: 선택. **18×18 고정, 텍스트와의 간격 4px**. 단 **32 Small에는 아이콘을 사용하지 않는다**.

## 문서 분할

| 파일                         | 다루는 내용                                                       |
| ---------------------------- | ----------------------------------------------------------------- |
| [variants.md](./variants.md) | 색(Color) × 형상(Shape) 조합                                      |
| [sizes.md](./sizes.md)       | 32 / 44 / 50 / 56 사이즈별 padding·radius·text                    |
| [states.md](./states.md)     | Enabled/hover/focus-visible/Pressed/Disabled (+loading) + a11y AC |
| [recipes.md](./recipes.md)   | 구현 스켈레톤 · Long-content/Overflow · Do/Don't                  |

## 토큰 요약

- Color: `color.bg.brand` / `color.brand.primaryLow` / `color.bg.muted` / `color.text.primary` / transparent.
- Text: `text.title.16.semibold` / `text.title.15.semibold` / `text.body.14.medium` / `text.desc.13.medium`.
- Radius: `radius.sm` (32 Small) / `radius.md` (그 외).
- Spacing: `space.6` / `space.10` / `space.16` / `space.24` (사이즈별 padding).
