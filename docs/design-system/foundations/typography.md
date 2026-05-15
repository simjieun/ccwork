---
name: Typography
description: Pretendard 단일 패밀리, Text style 토큰 7종 (size/lh/weight/letter-spacing 묶음)
type: foundation
status: verified
figma-node: '1:2'
last-verified: 2026-05-14
verified-by: simjieun
---

# Typography

폰트 패밀리는 **Pretendard** 단일. 다국어(한·영) 폭 차이를 흡수하고 화면 본문 가독성을 우선한다.

## Font family

| 토큰                  | 값                                                                              |
| --------------------- | ------------------------------------------------------------------------------- |
| `font.family.primary` | `Pretendard`                                                                    |
| `font.family.stack`   | `Pretendard, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif` |

## Text style 토큰

Figma가 정의한 스타일을 그대로 사용한다. 사이즈/굵기/라인 높이/자간이 한 묶음이며, **부분만 조합해 쓰지 않는다**.

| 토큰                     | Family     | Weight         | Size   | Line-height | Letter-spacing | 용도                           |
| ------------------------ | ---------- | -------------- | ------ | ----------- | -------------- | ------------------------------ |
| `text.headline.20`       | Pretendard | SemiBold (600) | `20px` | `28px`      | `-0.4px`       | 페이지·섹션 헤드라인           |
| `text.title.16.semibold` | Pretendard | SemiBold (600) | `16px` | `24px`      | `-0.3px`       | 카드/모달 타이틀, 큰 본문 강조 |
| `text.title.15.semibold` | Pretendard | SemiBold (600) | `15px` | `24px`      | `-0.3px`       | 본문 내 강조, 버튼 50 Large    |
| `text.body.15.medium`    | Pretendard | Medium (500)   | `15px` | `24px`      | `-0.3px`       | 본문 기본(폼 필드, 입력 값)    |
| `text.body.14.medium`    | Pretendard | Medium (500)   | `14px` | `22px`      | `-0.3px`       | 보조 본문, 버튼 44 Medium      |
| `text.desc.13.medium`    | Pretendard | Medium (500)   | `13px` | `20px`      | `-0.2px`       | 설명문, 버튼 32 Small          |
| `text.desc.12.medium`    | Pretendard | Medium (500)   | `12px` | `18px`      | `-0.2px`       | 캡션, 메타정보                 |

> 라인 높이가 다른 변형(`SemiBold/Title-M` 16/22, `Medium/Body-S` 14/20)도 Figma에는 존재한다. 동일 사이즈의 변형이 필요해지면 추가 토큰으로 등재한다.

## 사용 규칙

- 본문 기본은 `text.body.15.medium`을 사용한다(**must**).
- 사이즈/굵기/라인 높이/자간을 분리해 임의 조합하지 않는다(**must**) — 위 표의 묶음을 그대로 사용한다.
- 한 화면에서 3단계 이상의 사이즈 혼합은 피한다(**should**).
- Pretendard 로딩 실패 대비 `font.family.stack` 전체를 적용한다(**must**).
