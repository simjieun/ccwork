# 태그 기능 이슈 분해 (Vertical Slicing)

> 기준 문서: [`prd.md`](./prd.md), [`spec-fixed.md`](./spec-fixed.md)
>
> 각 이슈는 데이터 모델 → API → Context → UI까지 가로지르며, **사용자가 앱 안에서 직접 관찰할 수 있는 동작 변화**를 단위로 한다. 코드 구조·아키텍처 결정은 사용자 시나리오의 AC가 아닌 각 이슈의 "구현 노트"에 둔다. 위에서 아래 순서로 빌드업되며, 앞 이슈가 다음 이슈의 토대가 된다.

---

## 이슈 #1. 노트 상세에서 태그를 추가·표시하고 저장하면 영속화된다

### 설명

태그 기능의 첫 입출력 루프를 닫는 최소 수직 슬라이스. 사용자는 노트 상세 화면에서 자유 텍스트로 태그를 입력해 `Enter` 또는 `,`(쉼표)로 chip을 확정하고, 저장 버튼을 누르면 `title` / `content` / `tags`가 단일 PATCH/POST로 함께 영속화된다. chip 확정 직전 정규화 규칙(trim → 빈값 거부 → 길이 ≤ 20 → 대소문자 무시 중복 거부)이 적용되며, IME 조합 중인 `Enter`는 chip 확정을 트리거하지 않는다.

본 이슈는 이전 분해의 "데이터 모델 도입", "chip 표시", "태그 추가 + 정규화 + 저장" 세 단계를 하나의 수직 슬라이스로 합친 것이다. 별도 read-only 표시 단계 없이, 데이터 통로 개설부터 사용자 입력으로 chip이 만들어지고 서버에 저장되는 흐름까지를 한 번에 닫는다.

본 이슈는 US-1, US-3, US-4, US-5, US-6을 충족한다(태그 삭제 US-2는 이슈 #2, 새 노트 생성 시 영속화 US-4 일부는 이슈 #3에서 다룬다).

### 완료조건 (Acceptance Criteria)

**AC-1. Enter / 쉼표로 chip이 확정되고 화면에 표시된다**

- **Given** 노트 상세 화면에서 태그 입력란에 포커스가 있고 값이 `react`인 상태
- **When** 사용자가 `Enter` 또는 `,` 키를 누른다
- **Then** `react` chip이 chip 목록 끝에 추가되고 input은 비워진다. 네트워크 호출은 발생하지 않는다

**AC-2. trim과 빈 문자열은 조용히 거부된다**

- **Given** input 값이 `"  react  "` 또는 `""` 또는 `"   "` 중 하나
- **When** 사용자가 `Enter`를 누른다
- **Then** `"  react  "`는 `"react"`로 trim 되어 chip 추가되고, 빈/공백만 있는 경우는 에러 표시 없이 input만 비워지며 chip은 추가되지 않는다

**AC-3. 20자 초과 입력은 입력 단계에서 차단된다**

- **Given** 태그 입력란에서 사용자가 20자를 입력한 상태
- **When** 사용자가 추가 문자를 입력하려 한다
- **Then** 21번째 문자는 input에 들어가지 않는다

**AC-4. 대소문자 무시 중복은 거부되고, 통과한 값은 원본 케이스를 유지한다**

- **Given** 현재 태그가 `["react"]`이고 input 값이 `"REACT"` 또는 `"React"`
- **When** 사용자가 `Enter`를 누른다
- **Then** chip은 추가되지 않고 input만 비워진다. 반면 입력값이 `"Vue"`였다면 `"Vue"` 그대로(소문자로 정규화되지 않은 채) chip이 추가된다

**AC-5. IME 조합 중 Enter는 chip을 만들지 않는다**

- **Given** 한글 IME에서 사용자가 `리액트`를 조합 중이고 아직 조합이 확정되지 않은 상태
- **When** 사용자가 `Enter`를 누른다
- **Then** chip은 추가되지 않고 IME 조합 확정만 일어난다. 사용자가 다시 `Enter`를 누르면 그때 chip이 확정된다

**AC-6. chip 목록은 입력 순서대로 표시되고, 넘치면 줄바꿈된다**

- **Given** 사용자가 `react`, `study`, `typescript` 순으로 다수의 chip을 추가했다
- **When** chip 영역을 한 줄로 담을 수 없을 만큼 chip이 많아진다
- **Then** chip은 입력된 순서를 유지한 채 `flex-wrap`으로 다음 줄로 넘어가며, 가로 스크롤이나 truncate 없이 모두 보인다

**AC-7. 저장 버튼 클릭 시 tags가 일괄 PATCH 된다**

- **Given** 사용자가 제목/본문/태그를 모두 수정한 상태에서 저장 전
- **When** 사용자가 저장 버튼을 클릭한다
- **Then** `updateNote(id, { title, content, tags })`가 **단 한 번** 호출되고, 저장 중에는 `saving` 표시가 활성화된다. chip을 만지는 동안에는 어떤 PATCH도 발생하지 않는다

**AC-8. 저장 후 다른 노트를 봤다 돌아와도 태그가 그대로 보인다**

- **Given** 사용자가 태그를 추가하고 저장 버튼을 눌러 응답까지 받은 직후
- **When** 사이드바에서 다른 노트로 전환했다가 다시 원래 노트로 돌아온다
- **Then** 저장한 chip이 입력 순서 그대로 표시된다

**AC-9. 레거시 노트(`tags` 필드 누락)도 에러 없이 열린다**

- **Given** `tags` 필드가 없는 노트가 응답에 섞여 들어온다
- **When** 사용자가 사이드바에서 해당 노트를 선택한다
- **Then** 런타임 에러 없이 `NoteEditor`가 열리고, 태그 영역은 빈 상태로 표시되며, 그 자리에서 사용자가 새 태그를 추가·저장할 수 있다

### 구현 노트

본 이슈에서 함께 처리되어야 하는 구현 디테일. AC는 아니지만 PR 리뷰 시 확인 항목이다.

- `src/types/note.ts`의 `Note` 인터페이스에 `tags: string[]` 추가.
- `db.json`의 기존 노트 레코드에 모두 `"tags": []` 채워 마이그레이션.
- `src/api/notes.ts`의 `createNote` 입력 타입에 `tags: string[]`(필수), `updateNote`의 patch 타입에 `tags?: string[]`(선택) 반영. `updatedAt` 자동 삽입 등 기존 패턴 유지.
- `NotesContext`는 시그니처에 `tags`가 자연 통과하도록만 확장하고, 내부 분기 로직은 추가하지 않는다.
- 컴포넌트는 외부 응답의 누락에 대비해 `note.tags ?? []`로 안전 접근.
- 태그 입력 UI는 `TagInput` 하위 컴포넌트로 분리한다. Props는 `value: string[]`, `onChange: (tags: string[]) => void`. 서버 통신은 일절 하지 않는 controlled component.
- 정규화 규칙(trim, 빈값 거부, 대소문자 무시 중복)은 `src/lib/tag.ts` 등 순수 함수 유틸(`normalizeTag` / `tryAddTag`)로 분리해 RTL 없이 입력/기대값 표 기반 단위 테스트로 검증. 길이 제한은 input의 `maxLength={20}`로 입력 단계에서 차단.
- `NoteEditor`의 폼 상태와 저장 로직(`title`/`content`/`tags`/`saving` + `handleSave`)을 `useNoteEditor` 커스텀 훅으로 추출(PRD §3.1 ADR).
- chip 스타일은 디자인 시스템 토큰 / `foundations/tailwind-mapping.md` 매핑만 사용한다. raw hex/px 또는 Tailwind 임의값 클래스(`bg-[#fff]` 등) 금지.

---

## 이슈 #2. 노트 상세에서 chip 단위·Backspace로 태그를 삭제하고 저장하면 반영된다

### 설명

`TagInput`에 삭제 인터랙션을 더한다. 각 chip의 `✕` 버튼을 클릭하면 해당 chip이 즉시 사라지고, 입력란이 빈 상태에서 `Backspace`를 누르면 마지막 chip이 삭제된다. 삭제 역시 로컬 state 변경에 그치며, **저장 버튼 클릭 시** 변경된 `tags`가 함께 PATCH 된다.

본 이슈는 US-2를 충족하며, 이슈 #1에서 만든 일괄 저장 흐름과 `useNoteEditor` 훅을 그대로 재사용한다.

### 완료조건 (Acceptance Criteria)

**AC-1. chip의 ✕ 클릭으로 해당 chip이 삭제된다**

- **Given** 현재 태그가 `["react", "study", "typescript"]`로 표시되고 있다
- **When** 사용자가 `study` chip의 `✕` 버튼을 클릭한다
- **Then** chip 목록은 `["react", "typescript"]`로 갱신되고, 네트워크 호출은 발생하지 않는다

**AC-2. 빈 input에서 Backspace는 마지막 chip을 삭제한다**

- **Given** 태그가 `["react", "study"]`이고 input 값은 빈 상태에서 포커스가 있다
- **When** 사용자가 `Backspace`를 누른다
- **Then** 마지막 chip(`study`)이 삭제되고 태그는 `["react"]`로 갱신된다

**AC-3. input에 텍스트가 있을 때 Backspace는 chip을 삭제하지 않는다**

- **Given** 태그가 `["react"]`이고 input 값이 `"r"` 상태에서 포커스가 있다
- **When** 사용자가 `Backspace`를 누른다
- **Then** input은 비워지지만 chip 목록은 그대로 `["react"]`를 유지한다

**AC-4. 모든 chip을 삭제할 수 있다**

- **Given** 태그가 1개 이상 남아 있다
- **When** 사용자가 모든 chip의 `✕`를 차례로 클릭한다
- **Then** 태그 목록은 빈 배열이 되고, 빈 상태에서도 입력란이 계속 노출되어 새 태그를 추가할 수 있다

**AC-5. 저장 후 다시 열어봐도 삭제 결과가 유지된다**

- **Given** 사용자가 chip을 일부 삭제하고 저장 버튼을 눌러 응답까지 받았다
- **When** 사이드바에서 다른 노트로 전환했다가 원래 노트로 돌아온다
- **Then** 삭제 후의 chip 목록만 표시된다

### 구현 노트

- 삭제 핸들러는 `TagInput` 내부 `handleRemove`, 키 핸들러는 `handleKeyDown`으로 둔다(`spec-fixed.md` §10 네이밍).
- 삭제도 추가와 동일하게 `onChange(next: string[])` 한 경로로만 외부에 통보한다. 부모(`useNoteEditor`)는 추가/삭제를 구분하지 않고 새 배열을 받는다.

---

## 이슈 #3. 새 노트 생성 시 입력한 태그가 함께 영속화된다

### 설명

`isCreating` 흐름(새 노트 생성)에서도 동일한 `TagInput`을 사용해 태그를 입력·삭제할 수 있게 하고, 저장 시 `createNote(input)` 호출에 `tags: string[]`(빈 배열 허용)를 함께 전달한다. `useNoteEditor` / `TagInput` 구성을 편집 흐름과 공유하므로, 본 이슈는 주로 `createNote` 호출 경로에서 `tags`가 누락되지 않도록 확정하는 데 집중한다.

본 이슈가 끝나면 PRD §1의 성공 기준 3가지("추가/삭제", "저장 시 영속화", "레거시 호환")가 모두 충족된다.

### 완료조건 (Acceptance Criteria)

**AC-1. 새 노트 생성 화면에서도 태그 입력 UI가 보인다**

- **Given** 사용자가 사이드바에서 "새 노트" 버튼을 눌러 `isCreating` 상태로 진입했다
- **When** 빈 편집 화면이 표시된다
- **Then** 제목/본문 영역과 함께 태그 입력 영역이 보이고, 태그 추가/삭제가 기존 편집 흐름과 동일하게 동작한다

**AC-2. 태그를 입력한 채로 저장하면 새 노트에 그대로 영속화된다**

- **Given** 새 노트 작성 중 제목 `Hello`, 본문 `world`, 태그 `["react", "study"]`를 입력한 상태
- **When** 사용자가 저장 버튼을 클릭한다
- **Then** `createNote({ title: "Hello", content: "world", tags: ["react", "study"] })`가 호출되고, 응답으로 받은 노트가 로컬 state에 추가되며 사이드바에서도 보인다

**AC-3. 태그 없이 저장해도 빈 배열로 영속화된다**

- **Given** 새 노트 작성 중 태그를 하나도 추가하지 않은 상태
- **When** 사용자가 저장 버튼을 클릭한다
- **Then** `createNote` 페이로드의 `tags`는 `[]`로 전달되고, 생성된 노트는 `tags: []`로 저장된다(런타임 에러 없음)

**AC-4. 생성 직후 해당 노트를 다시 선택해도 태그가 그대로 보인다**

- **Given** 태그를 포함해 새 노트를 저장한 직후
- **When** 사용자가 사이드바에서 방금 생성된 노트를 다시 선택한다
- **Then** `NoteEditor`에 저장 시 입력한 chip이 동일한 순서로 표시된다

### 구현 노트

- `useNoteEditor` 훅이 편집/생성 양쪽 경로에서 `tags`를 동등하게 다루도록 한다. 분기는 저장 시 `updateNote` vs `createNote` 호출 선택에만 둔다.
