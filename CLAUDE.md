# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 프로젝트 개요

React 19 + TypeScript + Vite 기반 노트 앱 실습 프로젝트. JSON Server를 백엔드 목업으로 사용하며, 노트 CRUD 기능을 구현한다.

## 주요 명령어

```bash
npm run dev        # 개발 서버 (Vite + JSON Server 동시 실행)
npm run build      # 프로덕션 빌드 (tsc + vite build)
npm run lint       # ESLint 검사 및 자동 수정
npm run format     # Prettier 포맷
npm test           # 테스트 1회 실행
npm run test:watch # 테스트 감시 모드
npm run server     # JSON Server 단독 실행 (port 3001)
```

- 앱: http://localhost:5173
- API: http://localhost:3001/notes

## 아키텍처

### 데이터 흐름

```
db.json (JSON Server)
  └─ src/api/notes.ts       # fetch 기반 CRUD 함수
       └─ src/context/NotesContext.tsx  # 전역 상태 (notes, loading, error)
            └─ components              # useNotes() 훅으로 접근
```

### 레이어별 역할

- **`src/types/note.ts`** — `Note` 인터페이스 단일 정의 (`id`, `title`, `content`, `createdAt`, `updatedAt`)
- **`src/api/notes.ts`** — JSON Server REST API 직접 호출. `updatedAt`은 API 레이어에서 자동 삽입
- **`src/context/NotesContext.tsx`** — `NotesProvider` + `useNotes()` 훅. API 호출 후 로컬 state 동기 업데이트(낙관적 아님, 서버 응답값으로 갱신)
- **`src/App.tsx`** — `selectedNoteId`, `isCreating` 상태로 NoteList ↔ NoteEditor 간 선택/생성 흐름 조율
- **`src/components/`** — `Layout`(사이드바+메인 2열), `NoteList`, `NoteItem`, `NoteEditor`

### UI 구조

`Layout`이 사이드바(`NoteList`)와 메인 영역(`NoteEditor`)을 props로 받아 렌더링. 선택된 노트 ID는 `App`에서 관리하고 하위 컴포넌트에 내려줌.

## 구현 패턴

### 컴포넌트 패턴

- 모든 컴포넌트는 **named export** (`export function Foo`) — default export 없음
- Props 타입은 컴포넌트 파일 내부에 `interface XxxProps`로 인라인 정의
- 조건부 얼리 리턴으로 로딩/에러/빈 상태를 처리 후 정상 UI 렌더링 (`NoteList` 참고)
- 이벤트 핸들러는 컴포넌트 내부에 `handle` 접두사로 정의 (`handleSave`, `handleSelectNote`)
- 비동기 저장 중 상태는 컴포넌트 로컬 state로 관리 (`saving` in `NoteEditor`)

### 상태 관리

- 서버 데이터(`notes`, `loading`, `error`)는 `NotesContext`에서 단일 관리
- UI 선택 상태(`selectedNoteId`, `isCreating`)는 `App`에서 관리하고 props로 전달
- Context 뮤테이션은 서버 응답값으로 로컬 state를 갱신 (낙관적 업데이트 아님):
  - create: `setNotes(prev => [...prev, newNote])`
  - update: `setNotes(prev => prev.map(...))`
  - delete: `setNotes(prev => prev.filter(...))`

### API 호출 패턴

- `src/api/notes.ts`에 순수 fetch 함수만 모아둠 — 상태 처리 없음
- 응답이 `!res.ok`이면 즉시 `throw new Error(...)`, 성공 시 `res.json()` 반환
- `updatedAt` 타임스탬프는 API 함수 내부에서 `new Date().toISOString()`으로 자동 생성
- Context 레이어에서 `try/catch` 없이 에러를 위로 전파, 컴포넌트(`NoteEditor`)에서 `try/catch`로 처리
- 에러는 `alert` 대신 `console.error`로만 처리

### 네이밍 패턴

| 대상               | 패턴                | 예시                                                   |
| ------------------ | ------------------- | ------------------------------------------------------ |
| 컴포넌트 파일      | PascalCase          | `NoteEditor.tsx`                                       |
| 컴포넌트 함수      | PascalCase          | `NoteEditor`                                           |
| Props 인터페이스   | `{컴포넌트}Props`   | `NoteEditorProps`                                      |
| 커스텀 훅          | `use` 접두사        | `useNotes`                                             |
| 이벤트 핸들러 prop | `on` 접두사         | `onSelect`, `onDelete`, `onDone`                       |
| 이벤트 핸들러 구현 | `handle` 접두사     | `handleSave`, `handleNewNote`                          |
| API 함수           | camelCase 동사+명사 | `fetchNotes`, `createNote`, `updateNote`, `deleteNote` |
| Context 메서드     | API와 동일한 동사   | `createNote`, `updateNote`, `deleteNote`               |

> **일관성 없는 패턴 주의**
>
> - `Layout`에 `style={{ fontFamily: ... }}`와 `style={{ height: 'calc(...)' }}`처럼 인라인 style이 혼용됨 — 나머지 컴포넌트는 모두 Tailwind 클래스만 사용.

## 테스트 환경

- Vitest + jsdom + Testing Library (`@testing-library/react`, `@testing-library/user-event`)
- 전역 `globals: true` 설정 — `describe`, `it`, `expect` import 불필요
- 셋업 파일: `src/test-setup.ts` (`@testing-library/jest-dom` matchers 등록)

## 스타일

- Tailwind CSS v4 (Vite 플러그인 방식, `tailwind.config` 파일 없음)
- Prettier: `.prettierrc` 기준 자동 포맷
- **모든 스타일 작업은 `docs/design-system/`(N. Encar Design System Ver. 2.0)을 단일 출처로 참고한다.** 진입점은 [`docs/design-system/README.md`](./docs/design-system/README.md), 카탈로그는 [`docs/design-system/INDEX.md`](./docs/design-system/INDEX.md). 토큰은 [`foundations/`](./docs/design-system/foundations/), 규칙은 [`guidelines/`](./docs/design-system/guidelines/), 컴포넌트 스펙은 [`components/`](./docs/design-system/components/)에 있다. 토큰에 없는 raw hex/px, Tailwind 임의값 클래스(`bg-[#fff]` 등) 추가 금지. 새 값이 필요하면 `foundations/<category>.md`에 토큰을 먼저 추가하고 `foundations/tailwind-mapping.md`도 함께 갱신한다. 디자인 시스템 작업 시 `design-system` 스킬과 `/ds-add-token`·`/ds-verify`·`/ds-new-component` 슬래시 명령을 활용한다.

## 향후 추가 예정 (강의 진행 중)

- `Note` 타입에 `tags` 필드 추가
