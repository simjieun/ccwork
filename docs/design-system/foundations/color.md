---
name: Color
description: Palette(brand/gray/common) + 시맨틱 별칭(text/bg/border/icon/focus) 2층 토큰
type: foundation
status: verified
figma-node: '1:2'
last-verified: 2026-05-14
verified-by: simjieun
---

# Color

Figma는 색을 **팔레트(brand·gray·common)** 와 **시맨틱 별칭(text·bg·border)** 두 층으로 정의한다. 컴포넌트는 시맨틱 별칭만 참조한다.

## 1) Palette — 변하지 않는 원본 색

| 토큰                         | 값        | Figma 이름                      |
| ---------------------------- | --------- | ------------------------------- |
| `color.brand.primary`        | `#D72E36` | `Primary/Base`                  |
| `color.brand.primaryPressed` | `#BE152A` | `Primary/Pressed`               |
| `color.brand.primaryLow`     | `#FFD7D9` | `Primary/Low`                   |
| `color.brand.primaryBg`      | `#FFF2F2` | `Primary/Background`            |
| `color.gray.100`             | `#181818` | `Gray/100-Primary`              |
| `color.gray.90`              | `#333333` | `Gray/90`                       |
| `color.gray.80`              | `#666666` | `Gray/80-Secondary`             |
| `color.gray.60`              | `#A0A0A0` | `Gray/60-Description`           |
| `color.gray.50`              | `#CCCCCC` | `Gray/50-Placeholder, Disabled` |
| `color.gray.40`              | `#DADADA` | `Gray/40-Inactive`              |
| `color.gray.30`              | `#E9E9E9` | `Gray/30-Icon Disabled`         |
| `color.gray.20`              | `#F6F6F6` | `Gray/20-Background`            |
| `color.common.white`         | `#FFFFFF` | `Common/White`                  |

## 2) Semantic alias — 컴포넌트가 참조하는 토큰

| 토큰                     | 매핑                               | 용도                                                                         |
| ------------------------ | ---------------------------------- | ---------------------------------------------------------------------------- |
| `color.text.primary`     | `color.gray.100` (#181818)         | 본문 기본 텍스트                                                             |
| `color.text.secondary`   | `color.gray.80` (#666666)          | 보조 텍스트                                                                  |
| `color.text.description` | `color.gray.60` (#A0A0A0)          | 설명·메타                                                                    |
| `color.text.placeholder` | `color.gray.50` (#CCCCCC)          | 플레이스홀더, disabled 텍스트                                                |
| `color.text.inverse`     | `color.common.white` (#FFFFFF)     | 진한 배경 위 텍스트(Primary·Black 버튼)                                      |
| `color.text.brand`       | `color.brand.primary` (#D72E36)    | 강조 텍스트, 텍스트 링크 Primary                                             |
| `color.bg.default`       | `color.common.white` (#FFFFFF)     | 페이지 기본 배경                                                             |
| `color.bg.muted`         | `color.gray.20` (#F6F6F6)          | 카드·인풋 비활성 배경                                                        |
| `color.bg.brand`         | `color.brand.primary` (#D72E36)    | Primary 버튼 배경                                                            |
| `color.bg.brandLow`      | `color.brand.primaryLow` (#FFD7D9) | Primary Light 버튼 배경                                                      |
| `color.border.default`   | `color.gray.30` (#E9E9E9)          | 1px divider, border                                                          |
| `color.border.input`     | `color.gray.60` (#A0A0A0)          | 인풋 보더 기본                                                               |
| `color.border.strong`    | `color.gray.100` (#181818)         | Black Outlined 버튼 보더                                                     |
| `color.icon.disabled`    | `color.gray.30` (#E9E9E9)          | 비활성 아이콘                                                                |
| `color.focus.ring`       | `color.brand.primary` (#D72E36)    | 키보드 포커스 링 _— Figma 원본에 focus 상태 미정의, 브랜드 컬러로 임시 매핑_ |

## 사용 규칙

- 컴포넌트 코드에는 시맨틱 별칭만 쓴다(**must**). palette 토큰을 직접 참조하지 않는다.
- 텍스트와 배경 간 대비는 WCAG 2.2 AA(본문 4.5:1, 큰 글씨 3:1)를 만족해야 한다(**must**) — [accessibility.md](../guidelines/accessibility.md) 참고.
- 새 색이 필요하면 palette → semantic 순으로 토큰을 추가하고, 컴포넌트는 semantic만 참조한다(**must**).
- destructive/위험 액션 컬러는 현재 시스템에 별도 토큰이 없다 — `color.brand.primary`(빨강)가 브랜드와 액션을 동시에 표현하므로, 위험 시맨틱이 필요하면 `color.feedback.danger` 등으로 신규 토큰을 추가한 뒤 사용한다.
