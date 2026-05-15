# CLAUDE.md — docs/design-system/

이 폴더(또는 하위)에서 작업할 때 자동 주입되는 규칙. 메인 `CLAUDE.md`의 디자인 시스템 가이드를 보강한다.

## 단일 출처

- 본 폴더가 **모든 스타일 작업의 단일 출처**다. 컴포넌트 색·간격·반경 등을 코드에 박지 말고 여기서 토큰을 가져온다.
- 빠른 카탈로그는 [`INDEX.md`](./INDEX.md), 토큰은 [`foundations/`](./foundations/), 규칙은 [`guidelines/`](./guidelines/), 컴포넌트 스펙은 [`components/`](./components/).

## 작업 흐름

1. 사용자 요청을 받으면 작업 유형을 분류한다:
   - **토큰 추가/수정** → [`foundations/CLAUDE.md`](./foundations/CLAUDE.md)의 동기화 절차를 따른다(카논).
   - **컴포넌트 신규** → `components/<name>/README.md` 또는 단일 `components/<name>.md`. 변형 축 ≥3개면 폴더 분할(`button/` 예시 참고).
   - **컴포넌트 수정** → 해당 폴더의 모든 파일을 한 번에 검토(특히 `states.md`·`recipes.md` 일관성).
   - **Figma 검증** → Figma MCP `get_design_context`로 노드 재취득 후 spec과 diff.

2. 작업 후 frontmatter(`status`, `last-verified`, `verified-by`)를 갱신한다(**must**).

3. PR 전 [`guidelines/qa-checklist.md`](./guidelines/qa-checklist.md) 통과.

## 토큰 사용 규칙 (요약)

- 컴포넌트 코드에는 **시맨틱 별칭만**(`color.text.*`, `color.bg.*`, `color.border.*`). palette(`color.gray.100` 등) 직접 참조 금지.
- raw hex / raw px / Tailwind 임의값 클래스(`bg-[#fff]`, `p-[6px]`) 금지.
- 토큰에 없는 값이 필요하면 `foundations/`의 해당 파일에 먼저 추가.

## 문서 frontmatter 필수 필드

```yaml
---
name: <짧은 이름>
description: <한 줄 설명>
type: foundation | guideline | component | component-detail | index
status: verified | 검증필요 | draft
figma-node: '<node id 또는 TBD>' # foundation/component 만
last-verified: YYYY-MM-DD
verified-by: <github handle> # foundation/component 만
---
```

## 분할 vs 단일 파일

- 단일 변형 축이 ≤2개 → 단일 `.md` 파일.
- 변형 축 ≥3개 또는 본문 길이가 200줄을 넘으면 → 컴포넌트별 폴더로 분할(예: `components/button/` 구조: `README.md` + `variants.md` + `sizes.md` + `states.md` + `recipes.md`).

## 검증 필요 항목 다루기

- `status: 검증필요`인 파일은 디자이너 컨펌 전까지 컴포넌트에서 참조 금지(**must**). 임시 가이드는 본문 안에 명시.
- 사용자가 검증필요 항목을 확정하면, 본문 갱신과 함께 frontmatter `status`를 `verified`로 바꾸고 `last-verified`·`verified-by`를 동시에 갱신한다.
