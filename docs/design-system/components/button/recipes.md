---
name: Button Recipes
description: 구현 스켈레톤(Tailwind v4) · Long-content/Overflow · Do/Don't
type: component-detail
status: verified
figma-node: '1:2'
last-verified: 2026-05-14
verified-by: simjieun
---

# Button — Recipes

## 구현 스켈레톤 (Tailwind v4 기준)

```tsx
interface ButtonProps {
  color?: 'primary' | 'primaryLight' | 'gray' | 'black' | 'ghost';
  shape?: 'filled' | 'outlined';
  size?: '32' | '44' | '50' | '56';
  loading?: boolean;
  leadingIcon?: ReactNode; // size 32에서는 무시
  trailingIcon?: ReactNode; // size 32에서는 무시
  onClick?: () => void;
  disabled?: boolean;
  children: ReactNode;
}

export function Button({
  color = 'primary',
  shape = 'filled',
  size = '50',
  loading,
  disabled,
  ...rest
}: ButtonProps) {
  // 클래스는 토큰 매핑된 Tailwind 유틸만 사용
}
```

- `disabled`와 `loading`은 동시에 클릭이 차단되어야 한다.
- `size === '32'`일 때 `leadingIcon`/`trailingIcon` prop은 무시한다(콘솔 경고 옵션).
- 핸들러는 `onClick` prop으로 외부에서 주입, 컴포넌트 내부에서는 `handleClick`으로 받지 않는다 — 단순 트리거이므로 prop 그대로 사용한다.

## Long-content / Overflow / Empty

- 라벨이 컨테이너를 초과하면 **must** 한 줄로 자르고 ellipsis 처리한다(`overflow: hidden; text-overflow: ellipsis; white-space: nowrap;`).
- 화면 너비에 따라 폭이 변하는 위치(툴바 등)에서는 라벨 우선 표시, 공간 부족 시 leading icon만 표시 + `aria-label` 유지(**should**) — 단 `32 Small`은 아이콘 미사용 변형이므로 이 패턴을 적용하지 않는다.
- 빈 라벨 버튼은 만들지 않는다 — 아이콘 단독 버튼이면 **must** `aria-label`을 제공한다.

## Do / Don't

**Do**

- 한 화면의 주요 행동에 `Primary`를 1개만 둔다.
- 라벨은 행동 동사 + 명사 형태로 쓴다(`Save note`, `Delete`).
- 상태 변화는 색·테두리·텍스트 중 둘 이상을 같이 바꿔 색 의존을 피한다.
- 로딩 중에는 라벨 자리를 유지하고 spinner로 대체해 레이아웃 점프를 막는다.

**Don't**

- `Submit`, `OK`, `Click here` 같은 모호한 라벨을 쓰지 않는다.
- 같은 화면에 `Primary`를 두 개 이상 두지 않는다.
- `outline: none`만 적용해 포커스 표식을 제거하지 않는다.
- `32 Small`에 아이콘을 강제로 끼워 넣지 않는다 — 더 큰 사이즈로 올린다.
- 시각만으로 destructive를 표현하지 않는다. 현재 시스템에 위험 시맨틱 색이 별도로 없으므로, 파괴적 행동은 라벨 텍스트(`Delete`)와 확인 모달로 명시한다.
