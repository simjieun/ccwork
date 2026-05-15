---
name: Button States
description: Enabled/hover/focus-visible/Pressed/Disabled (+loading) + 키보드·터치 + a11y AC
type: component-detail
status: verified
figma-node: '1:2'
last-verified: 2026-05-14
verified-by: simjieun
---

# Button — States & Accessibility

Figma 원본은 `Enabled / Pressed / Disabled` 3개 상태를 정의한다. 웹 구현 시 키보드 접근성을 위해 `hover`와 `focus-visible`을 추가로 구현한다.

## 상태표

| State                      | 시각 규칙                                                                           | 보조 기술                                     |
| -------------------------- | ----------------------------------------------------------------------------------- | --------------------------------------------- |
| `Enabled` (default)        | 토큰대로                                                                            | —                                             |
| `hover` (web 추가)         | 배경 한 단계 진하게(Primary → Pressed 색에 근접), transition 100ms                  | —                                             |
| `focus-visible` (web 추가) | `color.focus.ring` 2px outline, offset 2px                                          | —                                             |
| `Pressed` (active)         | 배경 한 단계 더 진하게(예: Primary → `color.brand.primaryPressed`), scale 보정 없음 | —                                             |
| `Disabled`                 | 텍스트·배경을 비활성 톤(`color.gray.50` 계열)으로 약화, 커서 not-allowed            | `aria-disabled="true"` 또는 native `disabled` |

## 컴포넌트 단위 부가 상태 (선택)

| State     | 시각 규칙                               | 보조 기술                     |
| --------- | --------------------------------------- | ----------------------------- |
| `loading` | label 자리에 spinner, label은 `sr-only` | `aria-busy="true"`, 클릭 차단 |

> `error` 상태는 버튼 자체가 아닌 상위 폼 영역에서 처리한다(`role="alert"`).

## Keyboard / Pointer / Touch

- **Keyboard**: `Tab` 도달, `Enter` 또는 `Space`로 트리거. `Space` 누름 시 `Pressed` 상태를 유지하다 떼면 트리거(네이티브 `<button>` 동작 그대로).
- **Pointer**: 클릭 영역은 시각 박스 + 패딩 포함 전체.
- **Touch**: 가장 작은 `32 Small`도 패딩 포함 최소 32×32 — 24×24 기준은 자동 만족. 가능하면 44×44(**should**, 모바일 우선 화면).

## Accessibility AC

- **AC-B1**: `Tab`으로 도달 가능하고 `Enter`/`Space`로 활성화된다.
- **AC-B2**: `focus-visible` 시 `color.focus.ring`이 표시된다.
- **AC-B3**: disabled 상태에서 클릭과 키보드 트리거 모두 차단된다.
- **AC-B4**: loading 상태에서 `aria-busy="true"`이고 추가 클릭이 차단된다.
- **AC-B5**: 아이콘 단독 버튼은 `aria-label`을 가진다.
- **AC-B6**: 라벨/배경 대비 ≥ 4.5:1.
