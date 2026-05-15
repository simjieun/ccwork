---
name: QA Checklist
description: 머지 전 통과해야 하는 토큰/상태/접근성/카피/반응형/코드/문서 체크리스트
type: guideline
status: verified
last-verified: 2026-05-14
verified-by: simjieun
---

# QA Checklist

머지 전 통과해야 하는 체크리스트. 모든 항목 통과(✅) 시 리뷰어가 머지를 승인한다.

## 토큰

- [ ] raw hex / raw px / 임의 폰트 사이즈가 컴포넌트 코드에 없다.
- [ ] 새로 도입한 시각 값이 있다면 해당 foundations 파일의 토큰을 추가/갱신했다.
- [ ] 시맨틱 별칭(`color.text.*`, `color.bg.*` 등)을 사용했고, palette 토큰(`color.gray.100`, `color.brand.primary` 등)을 컴포넌트에서 직접 참조하지 않았다.
- [ ] 시맨틱 의미와 일치하는 토큰을 골랐다 (예: 의미가 다른데 `color.bg.brand`를 시각적 이유로 재활용하지 않았다).
- [ ] 새 토큰을 추가했다면 `foundations/tailwind-mapping.md`의 @theme 블록도 갱신했다.

## 컴포넌트 상태

- [ ] 최소 `Enabled` / `hover` / `focus-visible` / `Pressed`(active) / `Disabled` 5개 상태가 정의되어 있다.
- [ ] 비동기 트리거가 있다면 `loading`, 입력을 받는다면 `error` 상태가 추가로 정의되어 있다.
- [ ] 각 상태가 시각적으로 구별 가능하다(스크린샷 또는 Storybook).
- [ ] `Disabled` 상태에 `aria-disabled` 또는 네이티브 `disabled`가 적용되어 있다.

## 접근성

- [ ] 키보드만으로 인터랙션 전 경로를 수행했다.
- [ ] 포커스 링이 모든 인터랙티브 요소에 보인다(`color.focus.ring`).
- [ ] 본문 텍스트 대비 ≥ 4.5:1, 큰 텍스트/식별 요소 ≥ 3:1.
- [ ] 클릭/터치 타깃 ≥ 24×24 CSS px.
- [ ] 아이콘 단독 버튼에 `aria-label`이 있다.
- [ ] 폼 컨트롤에 `<label>` 또는 `aria-label*`이 연결되어 있다.
- [ ] 오류 메시지가 `aria-describedby`로 입력 필드에 연결되어 있다.
- [ ] `prefers-reduced-motion: reduce` 시 비필수 트랜지션이 비활성화된다.

## 콘텐츠·카피

- [ ] 버튼·링크 라벨이 행동 동사 + 명사 형태다.
- [ ] 에러 메시지에 다음 행동 안내가 포함되어 있다.
- [ ] 같은 행동에 같은 단어를 일관되게 사용했다.
- [ ] 모호한 표현(`Submit`, `OK`, `Click here`)이 없다.

## 반응형·경계 케이스

- [ ] 긴 텍스트(50자 이상) 입력 시 레이아웃이 깨지지 않는다(overflow/ellipsis 처리).
- [ ] 빈 상태(empty), 로딩, 에러 상태가 각각 정의되어 있다.
- [ ] 모바일 뷰포트(≤ 360px)에서 가로 스크롤이 생기지 않는다.
- [ ] 다국어(영문/한글) 라벨 길이 차이를 흡수하도록 폭이 고정되어 있지 않다.

## 코드 일관성(이 프로젝트)

- [ ] 컴포넌트는 named export.
- [ ] Props는 `interface XxxProps`로 컴포넌트 파일 내부에 정의.
- [ ] 이벤트 prop은 `on*`, 핸들러는 `handle*` 명명.
- [ ] 인라인 `style={{}}` 없이 Tailwind 클래스만 사용(legacy 잔존 시 별도 이슈).
- [ ] `npm run lint`, `npm run format`, `npm test` 모두 통과.

## 문서

- [ ] 새 컴포넌트라면 `docs/design-system/components/`에 문서가 추가되어 있다.
- [ ] 새 토큰이 추가됐다면 `foundations/*.md`에 반영되어 있다.
- [ ] 의도된 시각 변경이라면 PR 본문에 before/after 스크린샷이 있다.
- [ ] frontmatter의 `status`·`last-verified` 필드가 최신이다.
