---
name: Tailwind Mapping
description: Tailwind v4 @theme 블록 통합 매핑 — CSS custom property로 토큰 노출
type: foundation
status: verified
figma-node: '1:2'
last-verified: 2026-05-14
verified-by: simjieun
---

# Tailwind 매핑 가이드

이 프로젝트는 Tailwind v4를 사용한다. 토큰은 `@theme` 블록에 CSS custom property로 노출하고, Tailwind 유틸은 그 변수를 참조하게 한다. 개별 컴포넌트는 raw `bg-[#fff]`, `p-[6px]` 같은 임의값 클래스를 쓰지 않는다(**must**).

```css
/* 예시 — 실제 등록은 별도 PR */
@theme {
  /* palette */
  --color-brand-primary: #d72e36;
  --color-brand-primary-pressed: #be152a;
  --color-brand-primary-low: #ffd7d9;
  --color-brand-primary-bg: #fff2f2;
  --color-gray-100: #181818;
  --color-gray-80: #666666;
  --color-gray-60: #a0a0a0;
  --color-gray-50: #cccccc;
  --color-gray-30: #e9e9e9;
  --color-gray-20: #f6f6f6;
  --color-common-white: #ffffff;

  /* semantic */
  --color-text-primary: var(--color-gray-100);
  --color-text-inverse: var(--color-common-white);
  --color-bg-default: var(--color-common-white);
  --color-bg-muted: var(--color-gray-20);
  --color-border-default: var(--color-gray-30);
  --color-border-input: var(--color-gray-60);
  --color-focus-ring: var(--color-brand-primary);

  /* typography */
  --font-family-primary:
    'Pretendard', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
  --font-size-headline-20: 20px;
  --font-size-title-16: 16px;
  --font-size-title-15: 15px;
  --font-size-body-15: 15px;
  --font-size-body-14: 14px;
  --font-size-desc-13: 13px;
  --font-size-desc-12: 12px;

  /* spacing & radius */
  --space-4: 4px;
  --space-6: 6px;
  --space-8: 8px;
  --space-10: 10px;
  --space-11: 11px; /* 버튼 44 Medium 전용 */
  --space-12: 12px;
  --space-13: 13px; /* 버튼 50 Large 전용 */
  --space-14: 14px;
  --space-16: 16px;
  --space-20: 20px;
  --space-24: 24px;
  --radius-sm: 6px;
  --radius-md: 8px;
}
```

## 사용 규칙

- 토큰이 있는데 임의값(예: `p-[6px]`, `bg-[#fff]`)을 쓰지 않는다(**must**).
- palette 토큰을 컴포넌트 클래스에서 직접 참조하지 않는다 — semantic alias 클래스를 만들어 사용한다(**must**).
- 새 토큰이 추가되면 본 파일에 동시에 반영한다(**must**).
