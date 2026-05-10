---
name: mermaid-diagram
description: >
  프로젝트 구조를 Mermaid 다이어그램으로 시각화하여 HTML 파일로 저장하고 브라우저에서 열어준다.
  사용자가 "구조를 시각화", "아키텍처 다이어그램", "mermaid", "컴포넌트 의존성 그림", "의존성 시각화",
  "상태 흐름 다이어그램" 등을 언급할 때 이 스킬을 사용한다.
  사용자가 명시적으로 "mermaid-diagram 스킬" 또는 "/mermaid-diagram"을 언급해도 반드시 사용한다.
---

# mermaid-diagram

`src/` 디렉토리를 분석하여 프로젝트 구조를 Mermaid 다이어그램으로 시각화하고,
`docs/architecture/index.html`로 저장한 뒤 브라우저에서 연다.

## 실행 절차

1. `src/` 디렉토리의 모든 파일을 실제로 읽어서 분석한다.
   - 컴포넌트 간 import/export 의존성
   - Context/훅 사용 관계
   - 상태 흐름 (props, context를 통한 데이터 전달 방향)

2. 분석 결과를 바탕으로 두 가지 이상의 Mermaid 다이어그램을 작성한다.
   - **컴포넌트 의존성** (`graph TD`): 파일/컴포넌트 간 import 관계
   - **상태 흐름** (`flowchart LR`): 데이터/상태가 어디서 생성되어 어디로 흐르는지
   - **시나리오 시퀀스** (`sequenceDiagram`, 선택): 주요 사용자 액션 흐름

3. `docs/architecture/` 디렉토리를 생성(없으면)하고 `index.html`을 작성한다.
   - Mermaid.js CDN 방식으로 브라우저에서 바로 렌더링
   - 다이어그램을 탭으로 구분하여 표시
   - 다크 테마 권장

4. macOS에서는 `open docs/architecture/index.html`로 브라우저를 띄운다.

## 규칙

- 실제 파일을 읽어서 분석한다 — 추측 금지
- Mermaid 문법 오류 주의 (노드 이름 특수문자 이스케이프)
- HTML은 외부 서버 없이 로컬 파일로 바로 열 수 있어야 한다

## 출력

- `docs/architecture/index.html` 생성
- 브라우저 자동 실행 (macOS: `open` 명령어)
