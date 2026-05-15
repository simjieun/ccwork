# 태그 기능 정의서 (확정본)

> 원본: [`spec-original.md`](./spec-original.md)
> 본 문서는 원본의 기본 요구사항에 데이터 구조, UI 패턴, 엣지케이스 정책을 더해 구현 직전 단계까지 확정한 결과입니다.

## 1. 기능 개요

노트에 태그를 추가/삭제하고, 노트 상세 화면에서 현재 노트의 태그 목록을 확인할 수 있다.

## 2. 데이터 구조

### 2.1 저장 방식

- 별도의 `/tags` 엔드포인트나 `Tag` 엔티티는 두지 **않는다**.
- 각 노트 안에 문자열 배열로 임베드한다.

### 2.2 타입 변경

`src/types/note.ts`

```ts
export interface Note {
  id: string;
  title: string;
  content: string;
  createdAt: string;
  updatedAt: string;
  tags: string[]; // 신규
}
```

### 2.3 db.json 변경

- 기존 노트 레코드에 모두 `"tags": []`를 추가한다.
- 신규 노트는 생성 시 `tags`를 반드시 포함한다(기본값 `[]`).

### 2.4 컴포넌트 방어

- 외부 데이터의 누락 가능성에 대비해 컴포넌트에서는 `note.tags ?? []`로 안전 접근한다.

## 3. API 레이어 (`src/api/notes.ts`)

- `createNote(input)`의 입력 타입에 `tags: string[]`를 포함한다(필수).
- `updateNote(id, patch)`의 patch 타입에 `tags?: string[]`를 포함한다(선택).
- `updatedAt`은 기존과 동일하게 API 레이어에서 `new Date().toISOString()`로 자동 삽입.
- 응답 형식, 에러 처리(`!res.ok`이면 throw) 등 기존 패턴 유지.

## 4. Context (`src/context/NotesContext.tsx`)

- 시그니처만 따라간다. `tags`는 단순히 페이로드에 포함되어 흐를 뿐, Context 내부 분기 없음.
- 로컬 state 갱신 방식(낙관적 업데이트 아님, 서버 응답으로 set) 유지.

## 5. UI

### 5.1 표시 위치

- **노트 상세 화면(`NoteEditor`)에만 표시한다.**
- `NoteList`(사이드바)에는 태그를 노출하지 않는다 — 스펙 범위 밖.

### 5.2 레이아웃

`NoteEditor` 내부, 제목/본문 영역 사이 또는 본문 아래(구현 시 가독성 좋은 쪽 선택). 세부 클래스는 Tailwind로만 작성.

```
[ react ✕ ] [ study ✕ ] [ typescript ✕ ]
[ 태그 입력 후 Enter... ]
```

- chip은 가로 나열, 영역 넘치면 `flex-wrap`으로 줄바꿈.
- chip 내부에 태그 텍스트와 `✕` 버튼.
- 입력창은 chip 영역 옆 또는 바로 아래(단일 행 input).

### 5.3 입력 동작

| 키/조작                       | 동작                                                                           |
| ----------------------------- | ------------------------------------------------------------------------------ |
| `Enter`                       | 현재 input 값을 chip으로 확정 후 input 비움                                    |
| `,` (쉼표)                    | 동일하게 chip으로 확정 후 input 비움                                           |
| `Backspace` (input이 빈 상태) | 마지막 chip 삭제                                                               |
| chip의 `✕` 클릭               | 해당 chip 삭제                                                                 |
| IME 조합 중 `Enter`           | 조합 확정 처리이므로 chip 추가하지 **않음** (`e.nativeEvent.isComposing` 체크) |

### 5.4 컴포넌트 분리

- `NoteEditor` 안에 작은 하위 컴포넌트 `TagInput`을 둔다(같은 파일 내 또는 `src/components/TagInput.tsx`).
- Props: `value: string[]`, `onChange: (tags: string[]) => void`.
- chip 표시 + input + 키 핸들링을 책임진다. 서버 통신은 하지 않는다(부모가 일괄 저장).

## 6. 저장 타이밍

- 태그 변경은 `NoteEditor`의 로컬 state(`tags`)에 보관한다.
- **저장 버튼 클릭 시** `title`, `content`, `tags`를 한 번에 `updateNote`로 PATCH한다.
- 새 노트 생성(`isCreating`) 시에도 `createNote` 호출에 `tags`를 함께 전달한다(빈 배열 가능).
- `saving` 로컬 state로 저장 중 표시는 기존 패턴 그대로.
- 즉시 PATCH(chip 추가/삭제마다 호출)는 **하지 않는다**.

## 7. 정규화 규칙

chip으로 확정되기 직전에 입력값을 다음 순서로 처리한다.

1. **trim** — 앞뒤 공백 제거.
2. **빈 문자열 거부** — trim 결과가 빈 문자열이면 추가하지 않고 input만 비운다(에러 표시 없이 조용히 무시).
3. **길이 제한** — 1~20자. input에 `maxLength={20}` 속성으로 애초에 입력 자체를 제한한다.
4. **중복 검사 (대소문자 무시)** — 기존 태그와 `a.toLowerCase() === b.toLowerCase()` 비교해 동일한 게 있으면 추가하지 않는다(조용히 무시).
5. **저장 케이스** — 통과한 값은 **사용자가 입력한 원본 케이스 그대로** 저장한다(예: `React`로 입력했으면 `React`로 저장. 단, 이미 `react`가 있으면 추가 안 됨).

### 7.1 정규화 정책 요약

| 입력                         | 결과                               |
| ---------------------------- | ---------------------------------- |
| `"  react  "`                | `"react"`로 chip 추가              |
| `""` 또는 `"   "`            | 무시(추가 안 함)                   |
| 21자 이상                    | 입력 자체가 차단됨(`maxLength=20`) |
| 기존 `["react"]`에 `"REACT"` | 추가 안 함(대소문자 무시 중복)     |
| 기존 `["react"]`에 `"React"` | 추가 안 함(동일 사유)              |
| 특수문자/이모지              | 허용                               |

## 8. 엣지케이스

| 케이스                       | 처리                                                                |
| ---------------------------- | ------------------------------------------------------------------- |
| 빈/공백만 입력 후 Enter      | 추가하지 않음. input만 비움.                                        |
| 중복 입력(대소문자 무시)     | 추가하지 않음. input은 비움.                                        |
| 20자 초과 입력 시도          | `maxLength`로 입력 자체 차단.                                       |
| 한글 IME 조합 중 Enter       | chip 변환 트리거하지 않음. 조합 확정 후 다시 Enter를 눌러야 변환.   |
| 빈 input에서 Backspace       | 마지막 chip 삭제.                                                   |
| 노트당 태그 개수             | 별도 제한 없음.                                                     |
| 기존 노트에 `tags` 필드 없음 | 컴포넌트에서 `note.tags ?? []`로 방어. db.json은 함께 마이그레이션. |
| 저장 중 에러                 | 기존 패턴대로 `console.error`로만 처리(alert 사용 안 함).           |
| 매우 많은 chip               | `flex-wrap`으로 자연스럽게 줄바꿈. 별도 truncate/스크롤 처리 없음.  |
| 태그에 쉼표 입력 시도        | 쉼표는 chip 확정 트리거라 태그에 포함될 수 없음(의도된 동작).       |

## 9. 스펙 범위 밖(구현하지 않음)

다음은 본 스펙에서 **명시적으로 제외**한다. 후속 작업에서 추가될 수 있다.

- 태그 자동완성 / 기존 태그 풀에서 선택
- 태그로 노트 필터링/검색
- 태그 rename / 색상 / 아이콘 등 메타데이터
- 사이드바(`NoteList`)에 태그 표시
- 태그별 노트 개수 집계
- 태그 정렬 옵션

## 10. 네이밍

CLAUDE.md의 패턴을 그대로 따른다.

| 대상               | 이름                                         |
| ------------------ | -------------------------------------------- |
| 하위 컴포넌트      | `TagInput`                                   |
| Props 인터페이스   | `TagInputProps`                              |
| 이벤트 핸들러 prop | `onChange`                                   |
| 내부 핸들러        | `handleKeyDown`, `handleRemove`, `handleAdd` |

## 11. 작업 순서(가이드)

1. `src/types/note.ts` — `tags: string[]` 추가.
2. `db.json` — 기존 노트 레코드에 `"tags": []` 추가.
3. `src/api/notes.ts` — `createNote`/`updateNote` 입력 타입에 `tags` 반영.
4. `NotesContext` — 시그니처에 자연스럽게 흘려보내기(추가 로직 거의 없음).
5. `TagInput` 컴포넌트 신규 작성(chip + input + 키 핸들링 + 정규화).
6. `NoteEditor`에 `TagInput` 통합. 로컬 `tags` state + 저장 시 함께 PATCH/POST.
7. 테스트: 정규화 규칙(trim, 빈값, 대소문자 중복), Enter/쉼표 추가, Backspace 삭제, chip ✕ 삭제.
