---
name: Shadow
description: 검증 필요 — 디자이너 컨펌 대기 중인 stub
type: foundation
status: 검증필요
figma-node: TBD
last-verified: 2026-05-14
verified-by: simjieun
---

# Shadow

> **검증 필요** — 검토한 Figma 컴포넌트 셋(Buttons / Text Link / Input / Bullet list)에서는 명시적 shadow 스타일을 찾지 못했다. 모달·드롭다운·바텀시트 등 elevated 컴포넌트가 사용하는 그림자 토큰은 디자이너에게 별도 확인 후 등재한다.

## 확인이 필요한 항목

- elevated 컴포넌트(Modal Popup, Bottom Sheet, Dropdown, Toast)가 사용하는 그림자 스펙(blur, spread, x/y, color, opacity).
- 다단계 elevation 체계 유무(예: shadow.1 / shadow.2 / shadow.3).
- 상태별 그림자 변화(예: 카드 hover 시 elevation 한 단계 상승) 사용 여부.

## 임시 가이드

- elevation을 흉내 내려면 그림자 대신 `color.border.default` 1px 보더로 분리한다.
- shadow 토큰이 확정되기 전까지 컴포넌트 코드에 raw `box-shadow` 값을 박지 않는다(**must**).
