---
description: Figma MCP로 컴포넌트 노드를 재취득해 docs/design-system spec과 diff
---

지정된 컴포넌트의 Figma 디자인과 markdown spec을 비교 검증한다.

## 입력 인자

- **컴포넌트 이름** 또는 **Figma 노드 ID**.
- 컴포넌트 이름만 주어지면 해당 `docs/design-system/components/<name>(/README).md`의 `figma-node` frontmatter에서 노드 ID를 찾는다.

## 절차

1. **현재 spec 읽기**
   - `docs/design-system/components/<name>/` 폴더(또는 `<name>.md` 단일 파일) 전부 읽기.
   - frontmatter에서 `figma-node`, `last-verified`, `status` 확인.

2. **Figma 재취득**
   - Figma MCP `get_design_context`로 호출:
     - `fileKey`: `jtN1fCvaym0ncwSDyslfee` (N. Encar DS v2.0)
     - `nodeId`: spec의 `figma-node` (또는 사용자가 명시)
     - `disableCodeConnect: true` (Code Connect 프롬프트 회피)
   - 응답이 큰 경우(>50K chars) 화면 단위로 잘라 받는다.

3. **Diff**
   - 토큰 값 (색·padding·radius·text style)
   - 변형 축 (변형 이름 / 개수 / 조합)
   - 상태 정의
   - 아이콘 규칙 (사이즈·gap·금지 조건)

4. **결과 보고**
   - 일치 항목 수 / 불일치 항목 수 / 신규 발견 항목 수
   - 불일치는 spec 갱신 제안 (사용자 컨펌 후 수정).
   - 검증필요(status) 항목이 컨펌 가능해졌으면 `status: verified`로 전환 제안.

5. **갱신 후 처리**
   - 수정된 spec의 frontmatter:
     - `last-verified`: 오늘 날짜
     - `verified-by`: 현재 사용자
     - `status`: 필요 시 갱신
   - `INDEX.md` 카탈로그도 동기화.

## 사용 예

```
/ds-verify button
/ds-verify input
/ds-verify 1:2345
```

## 인자

$ARGUMENTS
