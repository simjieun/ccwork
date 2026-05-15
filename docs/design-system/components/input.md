---
name: Input
description: 기본 폼 인풋 — 5변형 × 3사이즈 × 2축 상태(타이핑 × 컴포넌트). 모듈 형태(라벨+helper+error) 포함
type: component
status: verified
figma-node: '1:2'
last-verified: 2026-05-14
verified-by: simjieun
---

# Input

사용자 입력을 받는 단일/조합 텍스트 필드. Figma는 **기본 형태**(필드 그 자체)와 **모듈 형태**(라벨·필수표기·텍스트링크와 조합한 그룹) 두 단위로 정의한다.

## 의도 (Design intent)

자유 형식의 사용자 입력을 안정적으로 수집하고, 라벨/도움말/오류로 입력 의도를 명확하게 안내한다.

## Anatomy

### 기본 형태 (Input)

```
┌──────────────────────────────────────┐
│ [Icon?]  value / placeholder         │  ← 우측 정렬 슬롯에 따라 변형
│                            [clear ⓧ] │
│                       [Text Unit?]    │
│                       [TextButton?]   │
│                       [Icon?]         │
└──────────────────────────────────────┘
```

- **Field**: container + value/placeholder + leading/trailing 슬롯.
- **Clear icon**(`icons/x_circle_filled`, 20×20): **타이핑 중일 때 must 노출**되어 한 번에 전체 삭제를 제공한다(아래 디자이너 정책 참고).

### 모듈 형태 (Input_Module)

```
Label [*]                                [Text Link?]   ← 라벨/필수표기/텍스트링크는 ON/OFF
┌──────────────────────────────────────┐
│ Input (기본 형태)                     │
└──────────────────────────────────────┘
Helper / Error message                                  ← 같은 슬롯 공유
```

- **Label / Required / Text Link** 각각 ON/OFF로 노출.
- **Helper text**: 항상 보이는 보조 안내.
- **Error message**: 에러 상태에서만 노출, helper text와 같은 슬롯을 공유.

## Variants (구성 형태)

| Variant                  | 설명                                            |
| ------------------------ | ----------------------------------------------- |
| `Text Only` (default)    | 텍스트만 입력. clear 아이콘만 trailing에 노출   |
| `with Text Button Unit`  | trailing에 텍스트 버튼(예: `중복확인`) 부착     |
| `with Text Unit`         | trailing에 보조 텍스트(예: 단위 `원`, `%`) 부착 |
| `with Icon Unit (Left)`  | leading에 아이콘(예: 검색 돋보기) 부착          |
| `with Icon Unit (Right)` | trailing에 아이콘 부착                          |

> 이 캔버스에는 `textarea` / `password` / `search` 같은 별도 변형이 정의돼 있지 않다. 다중 라인 입력이나 마스킹 입력이 필요하면 별도 토큰/컴포넌트로 추가한다.

## Sizes

| Size                 | Height | Padding (h × v)                     | Radius            | Text style            |
| -------------------- | ------ | ----------------------------------- | ----------------- | --------------------- |
| `52 Large` (default) | 52px   | `space.14` × `space.16`             | `radius.md` (8px) | `text.body.15.medium` |
| `48 Medium`          | 48px   | `space.14` × `space.14` (확인 필요) | `radius.md` (8px) | `text.body.15.medium` |
| `36 Small`           | 36px   | (확인 필요)                         | `radius.md` (8px) | `text.body.14.medium` |

> 52 Large는 Figma에서 직접 검증한 값(`px-14 py-16`, `rounded-8`)이다. 48/36의 padding은 별도 인스턴스 확인이 필요하므로 임시 표시. 구현 전 디자이너 또는 Figma 인스턴스로 재확인한다.

## States

Figma는 상태를 **2축으로 분리**해 정의한다: 타이핑 상태(value 유무) × 컴포넌트 상태.

### 타이핑 상태

| State         | 시각 규칙                                                                     |
| ------------- | ----------------------------------------------------------------------------- |
| `Placeholder` | value 없음, `color.text.placeholder` (#CCCCCC) 텍스트                         |
| `Typed`       | value 있음, `color.text.primary` (#181818) 텍스트, **clear 아이콘 must 노출** |

### 컴포넌트 상태

| State             | 시각 규칙                                                                                             | 보조 기술                                              |
| ----------------- | ----------------------------------------------------------------------------------------------------- | ------------------------------------------------------ |
| `Enabled`         | 보더 `color.border.input` (#A0A0A0) + 배경 `color.bg.default`                                         | —                                                      |
| `Pressed` (focus) | 보더 강조 + 필요 시 `color.focus.ring` 2px outline                                                    | —                                                      |
| `Disabled`        | 배경 `color.bg.muted`, 텍스트 `color.text.placeholder`, 커서 not-allowed                              | native `disabled`                                      |
| `Error`           | 보더 색을 위험 시맨틱(현재 시스템에 미정의, `color.brand.primary`로 임시) + helper 슬롯에 에러 메시지 | `aria-invalid="true"`, error 메시지 `aria-describedby` |

> 검토한 데이터에는 별도 `hover` / `loading` / `readonly` 상태가 표시되지 않는다. 구현 단계에서 보더 강조 정도의 hover와 trailing spinner 형태의 loading은 추가할 수 있다(시스템 토큰 변경 없이).

### 디자이너 정책 (검증된 must)

> _"텍스트를 타이핑 중인 경우 타이핑 중인 텍스트를 한번에 삭제할 수 있도록 기능이 구현되어야 합니다."_ 인풋필드 영역의 우측 끝에 `icons/x_circle_filled` 아이콘을 두고, **해당 아이콘에 전체 삭제 기능을 부여**한다(**must**).
>
> _(2024-09-24 정책)_ 인풋 내부 아이콘 사이즈는 **20×20으로 통일**한다.

## Keyboard / Pointer / Touch

- **Keyboard**:
  - `Tab` 도달, `Shift+Tab` 역방향.
  - `Enter`: form submit (`Text Only` 변형 기준).
  - `Esc`: 검증된 명시 없음 — `with Icon Unit (Left)` 검색 변형에서는 clear 아이콘 동작과 동일하게 매핑할 수 있다(**should**).
- **Pointer**: 라벨 클릭 시 입력 영역에 포커스가 전달돼야 한다(`<label htmlFor>` 연결 **must**, 모듈 형태에서 라벨 ON일 때).
- **Touch**: 모든 사이즈가 36px 이상이므로 24×24 기준은 자동 충족.

## Label / Helper / Error 슬롯 규칙 (모듈 형태)

- 라벨 ON일 때 **must** 시각적으로 보인다. 라벨 OFF일 때는 `aria-label`로 보강한다(**must**).
- Required 표기는 라벨 끝에 ` *` 또는 `(필수)`로 둔다. 색만으로 표시하지 않는다(**must**).
- helper text와 error message는 **같은 위치/높이** 슬롯을 공유한다 — 에러 노출 시 레이아웃 점프 없음(**must**).
- error 메시지는 무엇이 잘못됐는지 + 어떻게 해결할지 두 부분으로 작성한다([content-tone.md](../guidelines/content-tone.md) 참고).

## Long-content / Overflow / Empty

- 한 줄 텍스트가 컨테이너를 초과하면 사용자가 입력 중인 값을 잘라 보여주지 않는다 — 가로 스크롤로 그대로 표시한다.
- placeholder는 라벨/예시를 대신하지 않는다 — 예시 텍스트로만 사용하고, 라벨이 항상 따로 있어야 한다(**must**, 모듈 형태에서 라벨 ON 기준).

## 토큰 요약

- Color: `color.border.input` / `color.bg.default` / `color.bg.muted` / `color.text.primary` / `color.text.placeholder` / `color.text.brand`(텍스트 버튼).
- Text: `text.body.15.medium` (필드 값) / `text.body.14.medium` (텍스트 버튼) / `text.desc.13.medium` (helper).
- Radius: `radius.md` (8px).
- Spacing: `space.14` × `space.16` (52 Large 패딩).
- Icon: 필드 내부 통일 20×20.

## 구현 메모

- `id`/`htmlFor` 연결을 모듈 컴포넌트 내부에서 자동 생성한다(`useId()`).
- `aria-describedby`는 helper와 error 양쪽 id를 동시에 가리킬 수 있다(공백 구분).
- `aria-invalid`는 error 상태에서만 `"true"`로 설정한다.
- `clear` 버튼은 typed 상태에서만 렌더하고, 클릭 시 입력값을 빈 문자열로 초기화한 뒤 input에 포커스를 다시 둔다.

```tsx
interface InputProps {
  label?: string; // 모듈 형태에서만 사용, 기본 형태는 받지 않음
  required?: boolean;
  helperText?: string;
  errorMessage?: string;
  variant?: 'textOnly' | 'withTextButton' | 'withTextUnit' | 'withIconLeft' | 'withIconRight';
  size?: '36' | '48' | '52';
  // ...
}
```

## Accessibility AC

- **AC-I1**: 라벨 ON 케이스는 `<label htmlFor>`로 연결되고, OFF 케이스는 `aria-label`이 있다.
- **AC-I2**: error 상태에서 `aria-invalid="true"` 및 `aria-describedby`가 설정돼 있다.
- **AC-I3**: required 표기가 색 외 텍스트로도 전달된다.
- **AC-I4**: 키보드만으로 값 입력·삭제·제출이 가능하다(clear 아이콘도 키보드 포커스 가능).
- **AC-I5**: 보더/텍스트 대비 ≥ 3:1 (식별 요소), 본문 텍스트 대비 ≥ 4.5:1.
- **AC-I6**: 라벨/필드/도움말/에러 사이 시각 순서가 보조 기술의 읽기 순서와 일치한다.

## Do / Don't

**Do**

- 모듈 형태에서 라벨 ON이면 라벨을 항상 보이게 둔다.
- typed 상태에서 clear 아이콘을 노출해 한 번에 삭제 가능하게 한다.
- helper와 error는 같은 슬롯을 공유해 레이아웃 점프를 막는다.
- error 메시지는 원인 + 다음 행동 두 부분으로 적는다.
- required는 텍스트 표기까지 함께 둔다.

**Don't**

- placeholder를 라벨 대용으로 쓰지 않는다.
- 색만으로 required/error를 표현하지 않는다.
- 입력 중인 값을 ellipsis로 잘라 보여주지 않는다.
- clear 아이콘을 마우스 hover 시에만 노출하지 않는다 — 키보드 사용자가 도달할 수 없다.
- disabled에 시각만 적용하고 `aria-disabled`/`disabled`를 빼지 않는다.
