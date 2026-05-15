---
name: Bullet list
description: 본문 타이포 장식 컴포넌트 — 5형태 × 3밀도 × 3사이즈. 인터랙티브 리스트는 별도
type: component
status: verified
figma-node: '1:2'
last-verified: 2026-05-14
verified-by: simjieun
---

# Bullet list

본문 안에서 항목을 나열할 때 사용하는 **타이포그래피 장식 컴포넌트**. Figma 이름은 `Bullet list`. 인터랙션이나 선택 상태는 없다.

> **이 문서가 다루지 않는 것**: 키보드로 항목을 이동·선택·실행할 수 있는 **인터랙티브 리스트**(메일함, 알림 트레이 등)는 Figma 본 캔버스에 정의돼 있지 않다. README의 _검증 필요_ 섹션 참고.

## 의도 (Design intent)

본문 안에서 동질적인 항목을 시각적으로 정리해 스캔성을 높인다. 항목 자체는 텍스트만이며, 클릭/선택 인터랙션은 항목 내부의 텍스트 링크가 담당한다.

## Anatomy

```
[bullet]  Label
[bullet]  Label
[bullet]  Label
```

- **Bullet**: 점·대시·별 등 시각 표식. 정해진 5가지에서만 고른다.
- **Label**: 단일 텍스트(본문 1줄, 줄바꿈 시 들여쓰기 정렬).

## Variants

3개 축(형태 × 규칙 × 사이즈)의 조합으로 정의한다.

### 형태 (Bullet style)

| Variant                   | Bullet | 비고                       |
| ------------------------- | ------ | -------------------------- |
| `Dot` (default)           | `•`    | 가장 일반적인 본문 리스트  |
| `Dash`                    | `–`    | 부정형/대조 항목           |
| `Asterisk`                | `*`    | 본문 주석 1단계            |
| `Asterisk(Double)`        | `**`   | 본문 주석 2단계(이중 강조) |
| `Reference Mark` (당구장) | `※`    | 안내/유의사항              |

### 규칙 (Density)

리스트의 정보 위계와 항목 간 여백을 결정한다.

| Variant            | 용도                                       |
| ------------------ | ------------------------------------------ |
| `High`             | 헤드라인급 본문, 강조가 필요한 짧은 리스트 |
| `Medium` (default) | 일반 본문 리스트                           |
| `Low`              | 보조 정보, 캡션 영역의 리스트              |

### 사이즈

폰트 사이즈와 라인 높이를 결정한다.

| Size          | Text style            |
| ------------- | --------------------- |
| `S`           | `text.desc.12.medium` |
| `M` (default) | `text.desc.13.medium` |
| `L`           | `text.body.14.medium` |

## States

`Bullet list`는 정적 컴포넌트이므로 별도의 인터랙션 상태가 없다. 단, **전체 목록 수준**의 표시 상태는 사용처(상위 컴포넌트)에서 처리한다.

- **Loading**: skeleton 라인 3~5개로 대체, `aria-busy="true"` (상위 컨테이너).
- **Empty**: 빈 상태 메시지로 대체. 빈 `<ul>`을 렌더하지 않는다.
- **Error**: 에러 메시지 + 재시도 액션, `role="alert"` (상위 컨테이너).

## 토큰 요약

- Color: `color.text.primary` (기본) / `color.text.secondary` (Density `Low` 시) — Figma 실측 텍스트는 보조 톤(`#666`) 빈도가 높다.
- Text: `text.desc.12.medium` / `text.desc.13.medium` / `text.body.14.medium`.
- Spacing: 항목 사이 gap은 `space.6` (Bullet list 매트릭스에서 관찰).
- Bullet 자체에는 별도 색 토큰을 두지 않는다 — 라벨 색을 따른다.

## 시맨틱 마크업

- `<ul>` 또는 `<ol>` + `<li>` — Bullet 종류에 따라 적절히 선택한다.
- 시각 bullet을 `list-style: none`으로 끄고 직접 `::marker`나 CSS 콘텐츠로 그릴 때도 마크업은 시맨틱하게 유지한다(스크린리더가 리스트로 인지하도록).
- `Asterisk` / `Reference Mark` 변형은 본문 주석 의미가 강하므로, 본문에서 참조 번호와 함께 사용할 때 `aria-describedby`로 연결한다.

## Long-content / Overflow / Empty

- 항목이 컨테이너를 초과하면 줄바꿈한다. 이때 두 번째 줄은 bullet 아래가 아닌 라벨 시작 위치에 정렬한다(`padding-left` 또는 `text-indent`).
- 항목 수가 0개일 때는 상위 컴포넌트에서 empty 상태로 처리한다(빈 `<ul>` 금지).

## Accessibility AC

- **AC-BL1**: 리스트는 `<ul>`/`<ol>` + `<li>`로 마크업된다.
- **AC-BL2**: bullet 시각만 다르더라도 같은 시맨틱이면 같은 태그를 사용한다.
- **AC-BL3**: 본문 텍스트와 배경 대비 ≥ 4.5:1.
- **AC-BL4**: `Asterisk` / `Reference Mark` 주석 항목은 참조 텍스트와 보조 기술에서 연결돼 있어야 한다.

## Do / Don't

**Do**

- 한 리스트 안에서는 한 가지 bullet 변형만 사용한다.
- 같은 화면에서 위계가 같은 리스트들끼리는 density·사이즈를 통일한다.
- 항목이 짧고 동질적일 때만 리스트를 쓴다 — 단락이 되어야 할 내용은 문단으로 둔다.

**Don't**

- bullet 종류를 한 리스트 안에서 섞지 않는다(`Dot`과 `Dash` 혼용 금지).
- 시각 bullet만 그리고 시맨틱 마크업을 빼지 않는다(스크린리더가 리스트로 인지 못함).
- bullet 색을 라벨 색과 다른 의미 색(예: `color.brand.primary`)으로 강조하지 않는다 — 별도 시맨틱 컴포넌트가 필요하면 추가한다.
