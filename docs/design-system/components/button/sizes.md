---
name: Button Sizes
description: 32/44/50/56 사이즈별 padding·radius·text style. 50 Large 기본
type: component-detail
status: verified
figma-node: '1:2'
last-verified: 2026-05-14
verified-by: simjieun
---

# Button — Sizes

| Size                 | Height | Padding (h × v)         | Radius            | Text style               |
| -------------------- | ------ | ----------------------- | ----------------- | ------------------------ |
| `56 X-Large`         | 56px   | `space.16` × `space.16` | `radius.md` (8px) | `text.title.16.semibold` |
| `50 Large` (default) | 50px   | `space.16` × `space.13` | `radius.md` (8px) | `text.title.15.semibold` |
| `44 Medium`          | 44px   | `space.24` × `space.11` | `radius.md` (8px) | `text.body.14.medium`    |
| `32 Small`           | 32px   | `space.10` × `space.6`  | `radius.sm` (6px) | `text.desc.13.medium`    |

> `space.11` / `space.13`은 버튼 전용 토큰이다. 다른 컴포넌트의 패딩으로 확산하지 않는다(**must**).

## 아이콘 규칙

- 아이콘 사이즈는 **18×18 고정**(`56 / 50 / 44`만 해당, `32 Small`은 텍스트 전용).
- 아이콘-텍스트 간격은 4px.
