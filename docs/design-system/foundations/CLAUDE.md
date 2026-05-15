# CLAUDE.md — foundations/

토큰을 추가하거나 수정할 때 자동 주입되는 규칙. 상위 [`../CLAUDE.md`](../CLAUDE.md)를 보강한다.

## 토큰 변경 워크플로우 (필수 순서)

토큰을 추가/수정할 때 **반드시** 다음 파일을 한 번에 갱신한다(**must**):

1. **이 폴더의 해당 파일** — `color.md` / `typography.md` / `spacing.md` / `radius.md` / `shadow.md` / `motion.md` 중 의미에 맞는 곳에 토큰을 추가.
2. **`tailwind-mapping.md`** — `@theme` 블록에 CSS custom property 추가. 변수명은 `--<category>-<name>` 형태(예: `--color-bg-success`, `--space-32`).
3. **`../guidelines/qa-checklist.md`** — 새 토큰 검증 항목을 체크리스트에 반영(필요 시).
4. **frontmatter 갱신** — 본인이 수정한 파일의 `last-verified`·`verified-by` 갱신.

세 파일이 동시에 변경되지 않은 PR은 머지 차단 사유.

## 토큰 명명 규칙

- **palette**: `color.<family>.<scale>` — 예: `color.gray.80`, `color.brand.primaryPressed`.
- **semantic alias**: `color.<usage>.<role>` — 예: `color.text.primary`, `color.bg.brand`, `color.border.input`.
- 컴포넌트 코드는 **semantic alias만** 참조한다.
- 사이즈 토큰은 px 값을 그대로 이름에 둔다 — `space.16`, `radius.8`이 아닌 `radius.md`(의도된 단계명).
- 텍스트 토큰은 `text.<role>.<size>.<weight>` — 예: `text.body.15.medium`, `text.title.16.semibold`.

## 라이트/다크 또는 변형 색 추가 시

- palette는 단일 값이어도, semantic은 모드별로 분리 가능한 구조를 유지한다.
- 다크 모드는 별도 토큰 트리(`color.dark.*`)가 아닌 동일 semantic 이름의 모드 매핑으로 처리한다(필요 시 `tailwind-mapping.md`에 `@theme[data-theme=dark]` 추가).

## 검증필요 토큰

- `shadow.md`, `motion.md`는 status `검증필요`. 디자이너 컨펌 전에 컴포넌트에서 참조 금지(**must**).
- 컨펌이 들어오면 본문 갱신 + frontmatter `status: verified` + `tailwind-mapping.md` 일괄 반영.

## 토큰 삭제

- 토큰을 삭제하기 전에 코드베이스에서 사용처가 없음을 확인한다(**must**) — `rg "color\.text\.primary"` 등 grep.
- semantic alias 삭제는 매핑된 palette 삭제와 별개로 진행한다(매핑 변경만으로도 의미가 바뀔 수 있음).
