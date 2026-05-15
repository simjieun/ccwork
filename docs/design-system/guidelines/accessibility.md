---
name: Accessibility
description: WCAG 2.2 AA Acceptance Criteria — 키보드/포커스/대비/터치/라벨/상태/모션
type: guideline
status: verified
last-verified: 2026-05-14
verified-by: simjieun
---

# Accessibility — WCAG 2.2 AA

모든 컴포넌트는 **must** WCAG 2.2 AA를 만족한다. 키보드 우선 인터랙션, 가시적인 포커스, 충분한 대비를 기본으로 한다.

## Acceptance Criteria (테스트 가능 기준)

각 항목은 PR 머지 전 통과해야 한다. "통과 방법"은 구현 시 그대로 시나리오로 사용한다.

### 1. 키보드 조작

- **AC-K1**: 모든 인터랙티브 요소는 Tab 한 번으로 도달 가능하다.
  - 통과 방법: 마우스 없이 Tab만으로 페이지 전 인터랙티브 요소를 순회 → 누락 0개.
- **AC-K2**: Enter / Space로 버튼·링크가 활성화된다.
  - 통과 방법: 포커스 후 Enter/Space 입력 → 클릭과 동일하게 onAction 발화.
- **AC-K3**: Esc로 닫을 수 있는 컨테이너(모달, 메뉴 등)는 모두 Esc에 반응한다.
- **AC-K4**: 포커스 트랩은 모달 등 모달리티가 명시된 컨테이너에서만 동작한다. 일반 페이지에는 트랩이 없어야 한다.

### 2. Focus-visible

- **AC-F1**: 키보드로 포커스가 들어온 모든 요소는 가시적인 포커스 링을 가진다.
  - 통과 방법: `Tab` 진행 시 각 요소에 `color.focus.ring` 기반 outline이 보인다.
- **AC-F2**: 포커스 링은 배경과 3:1 이상 대비를 가진다.
- **AC-F3**: 마우스 클릭으로 들어온 포커스는 링을 표시하지 않아도 되지만(`:focus-visible` 활용), 키보드 포커스는 **must** 표시한다.
- **AC-F4**: 포커스 링은 `outline: none`만으로 제거하지 않는다 — 대체 가시 표식이 있어야 한다.

### 3. 대비

- **AC-C1**: 본문 텍스트와 배경 대비 ≥ 4.5:1.
- **AC-C2**: 큰 텍스트(`text.title.16.semibold` 이상, 또는 18.66px 환산 기준) 대비 ≥ 3:1.
- **AC-C3**: 인터랙티브 컴포넌트의 비텍스트 식별 요소(테두리, 아이콘 등) 대비 ≥ 3:1.
- **AC-C4**: 상태(hover/active/disabled)도 위 비율을 유지한다.

### 4. 터치 영역

- **AC-T1**: 인터랙티브 요소의 클릭/터치 타깃은 **must** 최소 24×24 CSS px이며, 가능하면 44×44를 권장(**should**).
- **AC-T2**: 시각 크기는 작아도 패딩으로 타깃을 확보할 수 있다.

### 5. 의미·라벨

- **AC-L1**: 모든 폼 컨트롤은 `<label>` 또는 `aria-label`/`aria-labelledby`로 라벨이 연결된다.
- **AC-L2**: 아이콘 단독 버튼은 **must** `aria-label`을 갖는다.
- **AC-L3**: 오류 메시지는 `aria-describedby`로 입력 필드와 연결된다.
- **AC-L4**: 비텍스트 콘텐츠(이미지, 차트)에는 대체 텍스트가 있다.

### 6. 상태 알림

- **AC-S1**: 동적으로 등장하는 알림(toast, error)은 적절한 `role="status"` / `role="alert"` 또는 `aria-live`로 안내된다.
- **AC-S2**: 로딩 상태는 시각 표시 + 보조 기술용 안내(`aria-busy`)를 함께 제공한다.

### 7. 모션 감응

- **AC-M1**: `prefers-reduced-motion: reduce` 시 비필수 트랜지션을 비활성화한다.
- **AC-M2**: 자동 재생 모션(캐러셀 등)은 일시정지 가능해야 한다.

## 테스트 방법

- **자동**: `eslint-plugin-jsx-a11y`, axe-core(테스트 환경), Storybook a11y addon(도입 시).
- **수동**: 키보드만으로 페이지 끝까지 조작, 포커스 가시성 육안 확인, 색 대비 도구로 측정.
- **스크린리더**: macOS VoiceOver, Windows NVDA로 핵심 흐름 1회 청취.

## Do / Don't

**Do**

- 키보드 인터랙션을 마우스 인터랙션과 동등하게 설계한다.
- 포커스 가시성을 시스템 토큰(`color.focus.ring`)으로 통일한다.
- 상태 변경은 시각 + 스크린리더 양쪽에 전달한다.

**Don't**

- `outline: none`만 적용한 채 대체 포커스 표식을 두지 않는 일은 금지한다.
- 색만으로 의미를 전달하지 않는다(아이콘·텍스트 보조).
- 24×24 미만의 클릭 타깃을 만들지 않는다.
