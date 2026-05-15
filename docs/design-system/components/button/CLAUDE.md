# CLAUDE.md — components/button/

버튼 컴포넌트 파일들을 수정할 때 자동 주입되는 규칙. 상위 [`../../CLAUDE.md`](../../CLAUDE.md)를 보강한다.

## 4축 일관성

버튼은 **색 × 형상 × 사이즈 × 상태** 4축 컴포넌트다. 한 축을 수정하면 다른 축에 미치는 영향을 항상 점검한다:

1. **색 추가/변경** ([variants.md](./variants.md))
   - 신규 색이 `Filled` / `Outlined` 두 형상 모두에 합리적인가?
   - Disabled / hover / Pressed 상태에서의 색 변화가 자연스러운가?
   - `color.text.inverse`가 새 배경 위에서 4.5:1 대비를 만족하는가?

2. **사이즈 추가/변경** ([sizes.md](./sizes.md))
   - 새 사이즈가 `space.*` 토큰만으로 구성되는가? 버튼 전용 `space.11`/`space.13` 외 신규 padding 값은 금지.
   - 아이콘 18×18 규칙이 유지되는가? 32 Small에 아이콘 허용은 **금지**.
   - radius는 `radius.sm`/`radius.md` 둘 중 하나만 사용.

3. **상태 추가/변경** ([states.md](./states.md))
   - 5개 필수 상태(Enabled/hover/focus-visible/Pressed/Disabled) 누락 없음.
   - `loading`은 선택, `error`는 버튼 자체에 두지 않고 상위 폼에서 처리.
   - 각 상태에 a11y AC(AC-B1~B6) 매핑.

4. **레시피 변경** ([recipes.md](./recipes.md))
   - Props 타입 시그니처가 variants/sizes/states 표와 1:1로 일치하는가?
   - Long-content/Overflow 규칙이 새 사이즈에도 적용되는가?

## 파일 동기화 규칙 (must)

- variants/sizes/states 표를 수정하면 [README.md](./README.md)의 "토큰 요약" 섹션과 [recipes.md](./recipes.md)의 Props 타입을 동시에 갱신한다.
- 새 토큰 사용 시 `../../foundations/`의 해당 파일에 토큰이 존재하는지 먼저 확인(없으면 토큰 추가 PR을 먼저).

## 한 화면 위계 규칙

- `Primary` 1개 제한은 **must**. 컴포넌트 코드에 lint 규칙으로 강제하기 어렵지만, 스토리북·예시 화면에서 위반 예시를 만들지 않는다.
- `Black` / `Primary Light` / `Outlined`로 위계 분리 가능. 다중 강조가 필요한 시나리오는 디자이너에게 새 변형 추가 요청.

## destructive 행동

- 현재 시스템에 위험 시맨틱 색 토큰 없음(**검증 필요**).
- 파괴적 행동(예: 노트 삭제)은 색 변형이 아닌 **라벨 텍스트(`Delete`) + 확인 모달**로 표현(**must**).
- 위험 색 토큰(`color.feedback.danger` 등)이 합의되면 본 파일 + variants.md에 위험 변형 추가.
