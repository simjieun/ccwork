---
name: design-system
description: >
  N. Encar Design System (Ver. 2.0) 작업 라우터. 사용자가 "디자인 시스템", "토큰",
  "스타일", "색", "버튼 변형", "input 사이즈", "Figma 검증" 등을 언급할 때 사용한다.
  필요한 문서만 골라 읽도록 안내하고, 토큰·컴포넌트 작업의 동기화 규칙을 강제한다.
  사용자가 명시적으로 "design-system 스킬" 또는 "/design-system"을 언급해도 반드시 사용한다.
---

# design-system

`docs/design-system/` 의 단일 출처 가이드를 효율적으로 탐색·갱신하기 위한 라우터.
전체 파일을 한 번에 읽지 말고, 작업 유형에 따라 필요한 파일만 골라 읽는다.

## 1단계 — 작업 유형 분류

사용자의 요청을 다음 5개 유형 중 하나로 분류한다:

| 유형                      | 신호어 예시                            | 필수 읽기                                                                                           |
| ------------------------- | -------------------------------------- | --------------------------------------------------------------------------------------------------- |
| **A. 토큰 조회**          | "토큰", "색 코드", "padding 값"        | [`docs/design-system/INDEX.md`](../../../docs/design-system/INDEX.md) → 해당 `foundations/*.md` 1개 |
| **B. 토큰 추가/수정**     | "토큰 추가", "새 색", "spacing 추가"   | `/ds-add-token` 슬래시 명령 사용 (또는 본 스킬 4단계 따라가기)                                      |
| **C. 컴포넌트 조회**      | "버튼 사이즈", "input variants"        | 해당 `components/<name>.md` 1개 또는 `components/<name>/<axis>.md`                                  |
| **D. 컴포넌트 신규/수정** | "새 컴포넌트 만들자", "버튼 변형 추가" | `/ds-new-component` 또는 본 스킬 5단계                                                              |
| **E. Figma 검증**         | "Figma와 맞나", "디자인 시스템 검증"   | `/ds-verify` 또는 본 스킬 6단계                                                                     |

## 2단계 — 필수 컨텍스트 읽기

분류와 무관하게 다음을 먼저 확인:

- [`docs/design-system/INDEX.md`](../../../docs/design-system/INDEX.md) — 카탈로그(어떤 파일이 verified인지)
- [`docs/design-system/CLAUDE.md`](../../../docs/design-system/CLAUDE.md) — 작업 흐름 규칙

이미 컨텍스트에 들어와 있으면 다시 읽지 않는다.

## 3단계 — 유형별 라우팅

### A. 토큰 조회

- 색: [`foundations/color.md`](../../../docs/design-system/foundations/color.md)
- 타이포: [`foundations/typography.md`](../../../docs/design-system/foundations/typography.md)
- 간격: [`foundations/spacing.md`](../../../docs/design-system/foundations/spacing.md)
- 반경: [`foundations/radius.md`](../../../docs/design-system/foundations/radius.md)
- Shadow/Motion: 검증필요 — 사용 전 사용자에게 알릴 것.

### B. 토큰 추가/수정

[`docs/design-system/foundations/CLAUDE.md`](../../../docs/design-system/foundations/CLAUDE.md)의 "토큰 변경 워크플로우"가 카논 — 그대로 따른다. 슬래시 명령 `/ds-add-token`을 쓰면 동일 절차가 자동화된다.

### C. 컴포넌트 조회

- 분할 컴포넌트(button): `components/<name>/README.md` 먼저 → 필요한 축 파일만(`variants.md`/`sizes.md`/`states.md`/`recipes.md`).
- 단일 파일 컴포넌트(input/link/list/card): 해당 `.md` 한 개.

### D. 컴포넌트 신규/수정

- 신규: `/ds-new-component` 사용 권장. 변형 축 ≥ 3개면 폴더 분할.
- 수정: 변경 영향 범위를 README.md/variants/sizes/states/recipes 전부에서 점검. 컴포넌트 폴더의 [`CLAUDE.md`](../../../docs/design-system/components/button/CLAUDE.md)가 자동 주입됨.

### E. Figma 검증

- `/ds-verify <component>` 사용 또는 수동 절차:
  1. Figma MCP `get_design_context` 호출(fileKey `jtN1fCvaym0ncwSDyslfee`, 해당 node).
  2. 반환된 토큰·치수·상태와 spec md 파일을 줄 단위로 diff.
  3. 차이가 있으면 spec 갱신 + frontmatter `last-verified` 오늘 날짜로.
  4. 검증필요 항목이 컨펌됐다면 `status: 검증필요` → `verified`로 전환.

## 4단계 — 출력 규칙

- 작업 결과 보고 시 어떤 파일을 수정했는지 한 줄 표로 정리(사용자가 추적 가능하도록).
- 토큰 작업이면 "B 유형 3파일 동시 갱신" 확인을 명시.
- 검증필요 항목을 그대로 둘 경우 사용자에게 명시.

## 5단계 — 금지 사항 (메인 규칙 강화)

- 컴포넌트 코드에 raw hex / raw px / Tailwind 임의값 클래스 추가 금지.
- palette 토큰(`color.gray.100` 등)을 컴포넌트에서 직접 참조 금지 — semantic alias만.
- `status: 검증필요` 토큰/컴포넌트를 production 코드에서 참조 금지.
