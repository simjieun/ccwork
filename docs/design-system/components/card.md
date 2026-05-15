---
name: Card
description: 검증 필요 — Figma 원본 부재. 임시 가이드와 결정해야 할 항목 명시
type: component
status: 검증필요
figma-node: TBD
last-verified: 2026-05-14
verified-by: simjieun
---

# Card

> **상태: 검증 필요 (Figma 원본 부재)**
>
> 본 문서가 참조하는 Figma 파일 [N. Encar Design System (Ver. 2.0)](https://www.figma.com/design/jtN1fCvaym0ncwSDyslfee/N.-Encar-Design-System--Ver.-2.0-?node-id=1-2&p=f&m=dev)의 `📚 컴포넌트 모음` 캔버스에는 **Card 컴포넌트가 정의돼 있지 않다**. 이전 버전 문서에 포함돼 있던 `flat / raised / subtle` 변형, shadow 토큰 매핑, clickable-card 패턴 등은 본 Figma 파일과 일치하지 않으므로 제거했다.

## 확인이 필요한 사항

다음 중 어느 쪽인지를 디자이너/PM에게 확인한 뒤 본 문서를 다시 작성한다.

1. **다른 Figma 라이브러리에 Card가 정의돼 있다** — 위치(파일 키, 노드 ID)를 받아 본 문서에 출처를 명시하고 변형·사이즈·상태를 그대로 옮긴다.
2. **Card를 직접 사용하지 않고 Modal Popup / Bottom Sheet / 그룹 컨테이너로 대체한다** — 본 파일은 삭제하고 README의 Index에서 항목을 빼되, 컨테이너 패턴은 해당 컴포넌트 문서에 흡수한다.
3. **새로 정의가 필요하다** — 디자이너가 Figma에 Card 컴포넌트를 신규 등록한 뒤, foundations 토큰 기반의 변형·상태표를 합의해 본 문서를 작성한다.

## 임시 가이드 (Figma 확정 전까지)

Card 컴포넌트가 확정되기 전 다음 패턴이 필요한 경우 임시로 다음 방식을 사용한다.

- **그룹 컨테이너**(클릭 없음): `color.bg.muted` (#F6F6F6) 배경 + `radius.md` (8px), 1px `color.border.default` (#E9E9E9) 보더.
- **흰 카드**: `color.bg.default` (#FFFFFF) 배경 + `radius.md` + `color.border.default` 1px 보더.
- **shadow는 사용하지 않는다** — shadow 토큰이 확정되지 않은 상태에서 elevation을 흉내내려면 보더로만 분리한다.

이 임시 가이드는 토큰 기반이므로 추후 Card 컴포넌트가 확정될 때 마이그레이션 영향이 작다.

## 미해결 결정 사항

- Card 외부 그림자(elevation) 사용 여부 — 시스템 전체의 shadow 토큰과 함께 결정해야 한다.
- 카드 자체가 클릭 가능한 모델을 시스템에서 허용할지 — 키보드 접근성 관점에서 컨테이너 카드 + 명시적 액션 분리 패턴이 더 안전하다.
- 카드 내부 라인 수 상한 — 카드 군마다 다르게 결정될 수 있어 본 문서가 아닌 사용처 문서에 정의되는 편이 적합하다.
