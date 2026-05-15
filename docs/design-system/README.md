# N. Encar Design System (Ver. 2.0)

구현 가능한, 토큰 기반의 UI 가이드. 모든 스타일 작업은 이 문서를 단일 출처로 삼는다.

> **Source**: [Figma — N. Encar Design System (Ver. 2.0)](https://www.figma.com/design/jtN1fCvaym0ncwSDyslfee/N.-Encar-Design-System--Ver.-2.0-?node-id=1-2&p=f&m=dev)
> Foundations 토큰과 컴포넌트 스펙은 Figma `📚 컴포넌트 모음` 캔버스를 기준으로 정규화한 것이다. 검증되지 않은 항목은 frontmatter `status: 검증필요`로 표시한다.

## Context & Goals

- **Product**: N. Encar Design System (Ver. 2.0) – Figma
- **Audience**: 개발자 및 기술 팀
- **Surface**: 문서 사이트(documentation site)
- **Visual style**: clean, functional, implementation-oriented
- **Mission**: 일관성, 접근성, 빠른 전달을 동시에 달성하는 토큰 기반 UI 가이드 제공

### Non-goals

- 시각 브랜딩 변형, 마케팅용 일회성 스타일.
- 토큰을 우회한 컴포넌트별 예외 처리.

## 사용법

1. 새 컴포넌트/화면 작업 전 [`foundations/`](./foundations/) 토큰을 먼저 확인한다.
2. 만들려는 UI에 대응되는 `components/*.md`의 상태표(states)를 그대로 구현한다.
3. PR 머지 전 [`guidelines/qa-checklist.md`](./guidelines/qa-checklist.md)를 통과시킨다.
4. 토큰에 없는 값이 필요하면 신규 토큰을 제안한다 — 인라인 raw 값 추가는 금지.

## Index

전체 카탈로그는 [`INDEX.md`](./INDEX.md)에서 확인.

| 영역             | 위치                                                                                                    |
| ---------------- | ------------------------------------------------------------------------------------------------------- |
| Foundations 토큰 | [`foundations/`](./foundations/) — color, typography, spacing, radius, shadow, motion, tailwind-mapping |
| Guidelines       | [`guidelines/`](./guidelines/) — accessibility, anti-patterns, content-tone, qa-checklist               |
| Components       | [`components/`](./components/) — button(분할), input, link, list, card                                  |

## 디렉토리 구조

```
docs/design-system/
├── README.md                  ← 사람용 진입점 (이 파일)
├── INDEX.md                   ← frontmatter 기반 카탈로그
├── CLAUDE.md                  ← Claude 자동 로딩(이 폴더 작업 시)
├── foundations/
│   ├── CLAUDE.md
│   ├── color.md / typography.md / spacing.md / radius.md
│   ├── shadow.md (검증필요) / motion.md (검증필요)
│   └── tailwind-mapping.md
├── guidelines/
│   └── accessibility.md / anti-patterns.md / content-tone.md / qa-checklist.md
└── components/
    ├── button/                ← 분할(README + variants/sizes/states/recipes)
    │   └── CLAUDE.md
    ├── input.md / link.md / list.md
    └── card.md (검증필요)
```

## Conventions

- **must** — 비협상 규칙. 위반은 머지 차단 사유.
- **should** — 권고. 일관성·시스템 우선이 원칙이므로 예외 시 PR 본문에 사유를 적는다.
- 토큰 표기: `color.text.primary`, `text.body.15.medium`, `space.16`처럼 점(`.`) 구분 네임스페이스를 사용한다.
- 코드 예시는 Tailwind CSS v4를 기본 가정한다(이 프로젝트의 스타일 스택).
- 모든 문서는 frontmatter(`name`, `description`, `type`, `status`, `last-verified`)를 갖는다.

## 검증 필요 (디자이너/PM 확인 사항)

목록·상세는 [`INDEX.md` 하단 "검증 필요 항목"](./INDEX.md#검증-필요-항목)에서 단일 출처로 관리한다. 확정 시 INDEX와 관련 문서의 frontmatter(`status` / `last-verified`)를 함께 갱신한다.
