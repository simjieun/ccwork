---
description: 디자인 시스템 토큰 추가/수정 (foundations + tailwind-mapping + qa-checklist 동시 반영)
---

디자인 시스템에 새 토큰을 추가하거나 기존 토큰을 수정한다.

## 입력 인자 (필요시 사용자에게 질의)

- **카테고리**: color / typography / spacing / radius / shadow / motion 중 하나
- **토큰 이름**: 점 구분 네임스페이스 (예: `color.bg.success`, `space.32`)
- **값**: hex / px / text style 묶음 등
- **종류**: palette (원본 색) 또는 semantic alias (컴포넌트 참조용)
- **사용처**: 어떤 컴포넌트가 사용할지

## 절차

본 명령은 [`docs/design-system/foundations/CLAUDE.md`](../../docs/design-system/foundations/CLAUDE.md)의 "토큰 변경 워크플로우 (필수 순서)"를 자동화한다 — 절차의 카논은 그 파일이다. 추가로 다음을 본 명령에서 책임진다:

- 변수명 컨벤션 강제: `--color-<usage>-<role>` / `--space-<num>` 형태.
- palette 추가 시 `palette` 표에, semantic 추가 시 `semantic alias` 표에 배치.
- `INDEX.md` 카탈로그 갱신(검증필요 → verified 전환 등 status 변화가 있을 때).

## 사용 가능성 점검 (must)

- 이미 같은 값/의미의 토큰이 있는지 grep으로 확인 (`rg "토큰값" docs/design-system/`).
- 시맨틱이 명확한가? 같은 색을 다른 의미로 쓰면 새 alias로 분리.

## 출력

작업 끝에 다음 표로 변경된 파일 보고:

| 파일                              | 변경                      |
| --------------------------------- | ------------------------- |
| `foundations/<category>.md`       | 토큰 row 추가 + 사용 규칙 |
| `foundations/tailwind-mapping.md` | `@theme` 변수             |
| `guidelines/qa-checklist.md`      | (해당 시)                 |
| `INDEX.md`                        | (해당 시)                 |

## 인자

$ARGUMENTS
