---
name: Index
description: frontmatter status 기반 디자인 시스템 카탈로그 (자동 생성 가능)
type: index
last-verified: 2026-05-14
---

# 디자인 시스템 카탈로그

> 각 파일의 frontmatter(`status`·`last-verified`·`figma-node`)를 한 화면으로 모은 카탈로그. 새 문서를 추가/검증할 때 본 표를 갱신한다.

## Foundations

| 문서                                                  | status   | last-verified | figma-node | 한 줄                           |
| ----------------------------------------------------- | -------- | ------------- | ---------- | ------------------------------- |
| [color](./foundations/color.md)                       | verified | 2026-05-14    | 1:2        | palette + semantic alias 2층    |
| [typography](./foundations/typography.md)             | verified | 2026-05-14    | 1:2        | Pretendard + text style 7종     |
| [spacing](./foundations/spacing.md)                   | verified | 2026-05-14    | 1:2        | 2~24px 스케일(11/13 버튼 전용)  |
| [radius](./foundations/radius.md)                     | verified | 2026-05-14    | 1:2        | sm(6) / md(8) 2단계             |
| [shadow](./foundations/shadow.md)                     | 검증필요 | 2026-05-14    | TBD        | elevated 컴포넌트 그림자 미확정 |
| [motion](./foundations/motion.md)                     | 검증필요 | 2026-05-14    | TBD        | duration/easing 미확정          |
| [tailwind-mapping](./foundations/tailwind-mapping.md) | verified | 2026-05-14    | 1:2        | @theme 통합 매핑                |

## Guidelines

| 문서                                           | status   | last-verified | 한 줄                         |
| ---------------------------------------------- | -------- | ------------- | ----------------------------- |
| [accessibility](./guidelines/accessibility.md) | verified | 2026-05-14    | WCAG 2.2 AA AC 7개 그룹       |
| [anti-patterns](./guidelines/anti-patterns.md) | verified | 2026-05-14    | 시스템 레벨 원칙·이유(왜)     |
| [content-tone](./guidelines/content-tone.md)   | verified | 2026-05-14    | UI 카피 톤·라벨링 규칙        |
| [qa-checklist](./guidelines/qa-checklist.md)   | verified | 2026-05-14    | 머지 전 체크박스(무엇을 확인) |

## Components

| 컴포넌트                                | status   | last-verified | figma-node | 한 줄                                 |
| --------------------------------------- | -------- | ------------- | ---------- | ------------------------------------- |
| [button](./components/button/README.md) | verified | 2026-05-14    | 1:2        | 색×형상×사이즈×상태 (5개 파일로 분할) |
| [input](./components/input.md)          | verified | 2026-05-14    | 1:2        | 5변형 × 3사이즈 × 2축 상태            |
| [link](./components/link.md)            | verified | 2026-05-14    | 1:2        | 색×사이즈×밑줄×아이콘                 |
| [list](./components/list.md)            | verified | 2026-05-14    | 1:2        | Bullet list — 5형태×3밀도×3사이즈     |
| [card](./components/card.md)            | 검증필요 | 2026-05-14    | TBD        | Figma 원본 부재 — 결정 대기           |

## 검증 필요 항목

- Shadow / Motion 토큰
- Card 컴포넌트 존재 여부
- Focus-visible 상태 색
- 인터랙티브 리스트(키보드 선택)
- 누락 컴포넌트: Footer Button Module, Select Box, Checkbox, Radio Button, Tab, Switch Toggle, Toast, Snackbar, Accent Bubble, Step Bar, Modal Popup, Bottom Sheet, Divider
