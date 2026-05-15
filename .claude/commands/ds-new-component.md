---
description: 새 컴포넌트 문서 스캐폴딩 (Figma fetch + frontmatter + 분할 여부 판단)
---

새 디자인 시스템 컴포넌트 문서를 스캐폴딩한다.

## 입력 인자

- **컴포넌트 이름** (kebab-case, 예: `select-box`, `radio-button`).
- 선택: Figma 노드 ID.

## 절차

1. **Figma 컨텍스트 수집**
   - Figma MCP `get_design_context`로 노드 정보 취득.
   - 변형 축 개수, 사이즈 개수, 상태 개수 파악.

2. **분할 여부 결정**
   - 변형 축 ≤ 2 → 단일 파일: `components/<name>.md`.
   - 변형 축 ≥ 3 또는 본문 200줄 초과 예상 → 폴더 분할:
     ```
     components/<name>/
     ├── README.md       (intent + anatomy + 토큰 요약)
     ├── variants.md     (변형 축들)
     ├── sizes.md        (사이즈가 있다면)
     ├── states.md       (상태 + a11y AC)
     ├── recipes.md      (구현 스켈레톤 + Do/Don't)
     └── CLAUDE.md       (이 컴포넌트 수정 규칙)
     ```

3. **frontmatter 템플릿**

   ```yaml
   ---
   name: <ComponentName>
   description: <한 줄 설명>
   type: component | component-detail
   status: draft # 초안 → 검증필요 → verified
   figma-node: '<nodeId>'
   last-verified: YYYY-MM-DD
   verified-by: <handle>
   ---
   ```

4. **본문 섹션 (button 패턴 따르기)**
   - 의도(Design intent)
   - Anatomy (ASCII 다이어그램)
   - Variants
   - Sizes (해당 시)
   - States (5상태 최소 + a11y AC)
   - Long-content / Overflow / Empty
   - 토큰 요약
   - 구현 메모 (Props 타입)
   - Do / Don't

5. **카탈로그 등록**
   - `INDEX.md` Components 표에 한 줄 추가.
   - `README.md`의 디렉토리 구조 그림 갱신(필요 시).

6. **상위 CLAUDE.md 영향 점검**
   - 새 컴포넌트가 검증필요 항목 중 하나라면 `docs/design-system/README.md`의 "검증 필요" 섹션에서 제거.

## 출력

- 생성된 파일 목록과 각 파일의 status를 표로 보고.
- 다음 액션 제안 (Figma 검증, 검증필요 → verified 전환 등).

## 인자

$ARGUMENTS
