#!/usr/bin/env bash
# ds-review-smoke.sh
# 디자인 시스템 ds-reviewer 서브에이전트가 제대로 검출하는지를 자동 검증한다.
# 6개 fixture를 차례로 적용 → grep 기반 자체 검출 → 즉시 복구.
# 자체 검출이 통과해야 같은 위반을 ds-reviewer도 잡을 수 있다(필요 조건 검증).
#
# 사용법:
#   bash scripts/ds-review-smoke.sh
#   DS_INTERACTIVE=1 bash scripts/ds-review-smoke.sh   # 매 fixture 적용 후 멈춰 사용자가 ds-reviewer 호출 비교
#
# 종료 코드: fail 개수가 그대로 반영(0이면 모두 통과).

set -uo pipefail

ROOT="$(git rev-parse --show-toplevel)"
cd "$ROOT"

pass=0
fail=0
report=()

readonly NOTE_EDITOR="src/components/NoteEditor.tsx"
readonly SPACING_MD="docs/design-system/foundations/spacing.md"
readonly TAILWIND_MD="docs/design-system/foundations/tailwind-mapping.md"
readonly BUTTON_STATES_MD="docs/design-system/components/button/states.md"
readonly INPUT_MD="docs/design-system/components/input.md"
readonly SHADOW_MD="docs/design-system/foundations/shadow.md"

readonly FILES_TOUCHED=("$NOTE_EDITOR" "$SPACING_MD" "$BUTTON_STATES_MD" "$INPUT_MD")

backup() { cp "$1" "$1.smokebak"; }
restore() { if [[ -f "$1.smokebak" ]]; then mv "$1.smokebak" "$1"; fi; }

cleanup_all() {
  for f in "${FILES_TOUCHED[@]}"; do
    restore "$f"
  done
}

trap 'echo; echo "[interrupt] 백업 복구"; cleanup_all; exit 130' INT TERM

record() {
  local result="$1"; local label="$2"
  if [[ "$result" == "PASS" ]]; then
    echo "  ✅ $label"
    pass=$((pass+1))
  else
    echo "  ❌ $label"
    fail=$((fail+1))
  fi
  report+=("$result $label")
}

pause_if_interactive() {
  if [[ "${DS_INTERACTIVE:-0}" == "1" ]]; then
    echo "  ⏸  fixture 적용 중. 별도 세션에서 ds-reviewer 호출 가능:"
    echo "       Agent({subagent_type: \"ds-reviewer\", prompt: \"현재 브랜치 DS 리뷰\"})"
    read -r -p "     Enter 키로 복구 + 다음 단계..."
  fi
}

# pipefail 환경에서 매치 실패가 ERR을 던지지 않도록 일관된 헬퍼.
# 디렉토리 인자도 받으니 grep -REc (재귀 + count) 사용. macOS BSD grep / GNU grep 호환.
match_count() {
  local pattern="$1"; shift
  grep -REc "$pattern" "$@" 2>/dev/null | awk -F: '{s+=$NF}END{print s+0}'
}

echo "================ ds-reviewer smoke test ================"

# -----------------------------------------------------------------------------
# F1 — raw hex / Tailwind 임의값 클래스
# -----------------------------------------------------------------------------
echo
echo "[F1] raw hex / Tailwind 임의값 클래스 검출"
backup "$NOTE_EDITOR"
{
  echo ''
  echo '// SMOKE-F1: <div className="bg-[#ff0044] p-[10px]">test</div>'
} >> "$NOTE_EDITOR"
pause_if_interactive
hex_hits=$(match_count '#[0-9a-fA-F]{6}\b' src/)
arb_hits=$(match_count '(bg-\[|p-\[|m-\[|w-\[|h-\[|text-\[)' src/)
[[ "$hex_hits" -gt 0 ]] && record PASS "raw hex 검출 (#ff0044)" || record FAIL "raw hex 검출"
[[ "$arb_hits" -gt 0 ]] && record PASS "Tailwind 임의값 클래스 검출" || record FAIL "Tailwind 임의값 클래스 검출"
restore "$NOTE_EDITOR"

# -----------------------------------------------------------------------------
# F2 — palette 직접 참조 (Tailwind 클래스)
# -----------------------------------------------------------------------------
echo
echo "[F2] palette 직접 참조 검출"
backup "$NOTE_EDITOR"
{
  echo ''
  echo '// SMOKE-F2: <div className="text-color-gray-100 bg-color-brand-primary">x</div>'
} >> "$NOTE_EDITOR"
pause_if_interactive
pal_hits=$(match_count 'color-(gray|brand|common)-' src/)
[[ "$pal_hits" -gt 0 ]] && record PASS "palette 직접 참조 검출" || record FAIL "palette 직접 참조 검출"
restore "$NOTE_EDITOR"

# -----------------------------------------------------------------------------
# F3 — foundations 토큰 추가, tailwind-mapping 미동기화
# -----------------------------------------------------------------------------
echo
echo "[F3] foundations(space.32) ↔ tailwind-mapping(--space-32) 동기화 누락 검출"
backup "$SPACING_MD"
{
  echo ''
  echo '<!-- SMOKE-F3 -->'
  echo '| `space.32` | `32px` |'
} >> "$SPACING_MD"
pause_if_interactive
spacing_has=$(match_count 'space\.32' "$SPACING_MD")
tw_has=$(match_count '\-\-space-32' "$TAILWIND_MD")
if [[ "$spacing_has" -gt 0 && "$tw_has" -eq 0 ]]; then
  record PASS "foundations 토큰 vs tailwind-mapping 동기화 누락 검출"
else
  record FAIL "동기화 누락 검출 (spacing_has=$spacing_has tw_has=$tw_has)"
fi
restore "$SPACING_MD"

# -----------------------------------------------------------------------------
# F4 — 5상태 중 focus-visible 누락
# -----------------------------------------------------------------------------
echo
echo "[F4] 5상태 누락 (focus-visible) 검출"
backup "$BUTTON_STATES_MD"
grep -v 'focus-visible' "$BUTTON_STATES_MD.smokebak" > "$BUTTON_STATES_MD"
pause_if_interactive
remaining=$(match_count 'focus-visible' "$BUTTON_STATES_MD")
if [[ "$remaining" -eq 0 ]]; then
  record PASS "focus-visible 누락 상태 검출"
else
  record FAIL "focus-visible 누락 (잔존 $remaining건)"
fi
restore "$BUTTON_STATES_MD"

# -----------------------------------------------------------------------------
# F5 — status:검증필요 토큰을 production 코드에서 사용
# -----------------------------------------------------------------------------
echo
echo "[F5] 검증필요(shadow) 토큰 코드 사용 검출"
backup "$NOTE_EDITOR"
{
  echo ''
  echo '// SMOKE-F5: const cardShadow = "shadow-shadow-1"; // shadow 토큰 임의 사용'
} >> "$NOTE_EDITOR"
pause_if_interactive
shadow_status=$(awk -F': ' '/^status:/{print $2; exit}' "$SHADOW_MD" | tr -d ' ')
code_uses_shadow=$(match_count 'shadow-shadow-1|shadow\.1' src/)
if [[ "$shadow_status" == "검증필요" && "$code_uses_shadow" -gt 0 ]]; then
  record PASS "검증필요 토큰 production 사용 검출"
else
  record FAIL "검출 실패 (shadow_status=$shadow_status code_uses_shadow=$code_uses_shadow)"
fi
restore "$NOTE_EDITOR"

# -----------------------------------------------------------------------------
# F6 — 본문 수정 후 frontmatter(last-verified) 미갱신
# -----------------------------------------------------------------------------
echo
echo "[F6] frontmatter 갱신 누락 (mtime > last-verified) 검출"
backup "$INPUT_MD"
echo '<!-- SMOKE-F6 -->' >> "$INPUT_MD"
# mtime을 명확히 미래로 — touch -t 로 내일 날짜 흉내
touch -t "$(date -v+1d '+%Y%m%d0000' 2>/dev/null || date -d 'tomorrow' '+%Y%m%d0000')" "$INPUT_MD" 2>/dev/null || true
pause_if_interactive
last_verified=$(awk -F': ' '/^last-verified:/{print $2; exit}' "$INPUT_MD" | tr -d ' ')
mtime_iso=$(date -r "$INPUT_MD" "+%Y-%m-%d")
if [[ -n "$last_verified" && "$mtime_iso" > "$last_verified" ]]; then
  record PASS "frontmatter 미갱신 검출 (mtime=$mtime_iso > last-verified=$last_verified)"
else
  record FAIL "검출 실패 (mtime=$mtime_iso last-verified=$last_verified)"
fi
restore "$INPUT_MD"

# -----------------------------------------------------------------------------
# 결과 요약
# -----------------------------------------------------------------------------
echo
echo "======================== 결과 ========================"
printf '%s\n' "${report[@]}"
echo "------------------------------------------------------"
echo "PASS=$pass  FAIL=$fail"

# 백업 잔존 점검
leftover=$(find src docs/design-system -name '*.smokebak' 2>/dev/null | wc -l | tr -d ' ')
if [[ "$leftover" -gt 0 ]]; then
  echo "⚠  .smokebak 잔존 파일 $leftover개 — 수동 정리 필요:"
  find src docs/design-system -name '*.smokebak'
fi

exit "$fail"
