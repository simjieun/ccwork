---
name: Text Link
description: 색(4) × 사이즈(3) × 밑줄(2) × 아이콘 조합. 인풋의 텍스트 버튼도 포함
type: component
status: verified
figma-node: '1:2'
last-verified: 2026-05-14
verified-by: simjieun
---

# Text Link

텍스트 기반 트리거. Figma 이름은 `Text Link`(또는 `TextButton`). 색·사이즈·밑줄·아이콘·상태의 5축 조합.

## 의도 (Design intent)

탐색 또는 짧은 보조 행동을 텍스트로 표현한다. 의미상 다른 페이지/위치로의 이동이 기본이지만, Figma의 정의상 인풋 모듈의 trailing `Text Button`처럼 액션 트리거로도 쓰인다.

## 언제 Text Link vs Button?

| 사례                                        | 컴포넌트                           |
| ------------------------------------------- | ---------------------------------- |
| 다른 페이지/외부 URL로 이동                 | **Text Link**                      |
| 같은 페이지 내 앵커로 이동                  | **Text Link**                      |
| 인풋 옆 보조 액션(예: `중복확인`, `재발송`) | **Text Link** (`Text Button` 변형) |
| 페이지의 주요 행동, 폼 제출                 | **Button**                         |

## Anatomy

```
[Leading icon?]  Label  [Trailing icon?]
```

- **Label**: 목적지 또는 행동을 드러내는 짧은 구.
- **Icon**: **16×16 고정, 텍스트와의 간격 2px**. 디자이너 명시 정책: _"밑줄이 없는 텍스트 링크에만 아이콘을 사용한다."_

## Variants

3개 축의 조합으로 정의한다.

### 색

| Color             | Label color                        | 용도                                    |
| ----------------- | ---------------------------------- | --------------------------------------- |
| `Black` (default) | `color.text.primary` (#181818)     | 본문 중 가장 일반적인 링크              |
| `Gray`            | `color.text.secondary` (#666666)   | 위계가 낮은 링크                        |
| `Gray Light`      | `color.text.description` (#A0A0A0) | 보조 정보 안의 링크(타임스탬프 클릭 등) |
| `Primary`         | `color.text.brand` (#D72E36)       | 행동 강조(인풋 텍스트 버튼, CTA 텍스트) |

### 사이즈

Figma는 사이즈를 폰트 사이즈로 명명한다.

| Size        | Text style            |
| ----------- | --------------------- |
| `15 Large`  | `text.body.15.medium` |
| `14 Medium` | `text.body.14.medium` |
| `13 Small`  | `text.desc.13.medium` |

### 밑줄

| Underline | 시각                                                       |
| --------- | ---------------------------------------------------------- |
| `On`      | 텍스트에 1px 밑줄                                          |
| `Off`     | 밑줄 없음 — **아이콘 부착이 가능한 변형은 이 모드에 한정** |

### 아이콘

| Icon        | 비고                                            |
| ----------- | ----------------------------------------------- |
| `None`      | 아이콘 없음                                     |
| `With Icon` | `Underline=Off` 변형에서만 사용. 16×16, gap 2px |

## States

| State                      | 시각 규칙                                                       | 보조 기술                                                   |
| -------------------------- | --------------------------------------------------------------- | ----------------------------------------------------------- |
| `Enabled` (default)        | 색·밑줄·아이콘은 변형 그대로                                    | —                                                           |
| `hover` (web 추가)         | 색 한 단계 강조 또는 밑줄 추가, transition 100ms                | —                                                           |
| `focus-visible` (web 추가) | `color.focus.ring` 2px outline (offset 2px)                     | —                                                           |
| `active` (web 추가)        | 색 더 강조                                                      | —                                                           |
| `Disabled`                 | 텍스트 톤을 비활성으로(`color.gray.50` 계열) + 커서 not-allowed | `aria-disabled="true"` (`<a>`는 `pointer-events:none` 보조) |

> Figma는 `Visited` 상태를 별도로 정의하지 않는다. 검색 결과 등 의미 있는 컨텍스트에서만 별도 색을 부여하고, 일반적으로는 Enabled 상태를 유지한다(**should**).

## Keyboard / Pointer / Touch

- **Keyboard**: `Tab` 도달, `Enter`로 이동/트리거. `Space`는 네이티브 `<a>` 동작상 트리거하지 않는다.
- **Pointer**: 텍스트 박스 + (아이콘 포함) 전체가 클릭 영역.
- **Touch**: 텍스트가 작은 `13 Small`도 타깃 ≥ 24×24를 만족하도록 패딩(부모) 또는 줄간격으로 흡수한다(**must**).

## Long-content / Overflow

- 본문 안에 들어가는 `Underline=On` 링크는 본문 줄바꿈을 따른다. 링크 단어가 줄 끝에서 잘리지 않게 `word-break`를 본문 규칙과 동일하게 적용한다.
- 단독 링크가 컨테이너를 초과하면 ellipsis(**should**). 단, 목적지를 드러내야 하므로 ellipsis 시 `title` 속성 또는 tooltip 보강(**should**).

## 토큰 요약

- Color: `color.text.primary` / `color.text.secondary` / `color.text.description` / `color.text.brand`.
- Text: `text.body.15.medium` / `text.body.14.medium` / `text.desc.13.medium`.
- Icon: 16×16 고정, gap `space.2` (2px) — `Underline=Off`에서만.
- Motion: hover 색 전환은 즉시 피드백 수준(상세는 motion 토큰 확정 후 등재).

## 구현 규칙

- 외부 도메인 또는 새 탭 이동 시 **must** `rel="noopener noreferrer"`를 포함한다(보안 — Figma 변형에 명시 없음이지만 웹 구현 표준).
- 새 탭 이동 시 시각 인디케이터(아이콘)와 `aria-label` 보강("(opens in new tab)" 또는 "(새 탭에서 열림)")을 함께 둔다(**must**).
- 단일 페이지 라우팅에서는 프레임워크의 Link 컴포넌트를 사용한다(**must**) — `<a>` 직접 사용 금지(전체 페이지 리로드 방지).

## Accessibility AC

- **AC-L1**: 키보드 `Tab`+`Enter`로 동작한다.
- **AC-L2**: 포커스 링이 보인다.
- **AC-L3**: 텍스트 색과 배경 대비 ≥ 4.5:1. 색 외에 밑줄/굵기/아이콘 중 하나로도 식별 가능(**must**) — `Underline=Off`일 때는 색 + 배치(예: 단독 행)로 식별성을 확보한다.
- **AC-L4**: 외부 링크는 시각 + 보조 기술 양쪽에서 외부 이동임이 안내된다.
- **AC-L5**: 링크 텍스트는 목적지/행동을 설명한다 — `여기`, `클릭`, `더 보기` 단독 금지.

## Do / Don't

**Do**

- 링크 텍스트에 목적지/행동 정보를 담는다(`대시보드로 이동`, `중복확인`).
- 외부 링크에는 아이콘과 `rel="noopener noreferrer"`를 함께 둔다.
- 아이콘을 쓸 때는 `Underline=Off` 변형으로 묶고, 사이즈를 16×16으로 유지한다.
- Disabled 상태는 시각 + `aria-disabled` 양쪽으로 표시한다.

**Don't**

- `여기 클릭`, `more`, `→`만 적힌 링크를 만들지 않는다.
- `target="_blank"` + `rel` 누락(보안 이슈)으로 두지 않는다.
- `Underline=On` 변형에 아이콘을 함께 붙이지 않는다 — Figma 정책 위반.
- 색만으로 링크임을 표시하지 않는다 — `Gray Light` 같은 약한 색은 반드시 배치/밑줄/아이콘 보강이 필요하다.
