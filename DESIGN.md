# DESIGN.md — shae-nim-file-searcher

SHAE Field Manual design system applied to this Nim CLI file searcher.

## Palette

| Role | Hex | Usage |
|------|-----|-------|
| Warm paper | #F2EEE5 | Table rules, negative space |
| Ink | #191712 | Primary text, titles, headers |
| Oxide signal | #B3341B | Matched lines, errors, single signal per view |

Colours are emitted via ANSI escapes (`ANSI_RESET`, `ANSI_INK`,
`ANSI_OXIDE`, `ANSI_PAPER`, `ANSI_BOLD`) in `src/file_searcher.nim`.

## Typography

- Body / labels: Instrument Sans (terminal falls back to system mono)
- Code / metadata: JetBrains Mono — tabular numerals keep size and match
  columns aligned

## Layout & form

- 0px radius — no rounded corners in the console UI
- 1px borders — hairline rules (`----`) separate sections
- Border-defined cards — the results block is framed by rules
- Left-aligned data — every column is left-aligned
- Uppercase only for short labels — modes stay lowercase (`name`, `content`)

## Motion

CLI; no animated UI. Any future TUI layer must use 140–240ms state
changes, transform/opacity/clip-path only, with `prefers-reduced-motion`
and `prefers-reduced-transparency` fallbacks. No animation libraries.

## Accessibility

- WCAG AA contrast between ink and paper; oxide used only as a signal
- Complete keyboard paths — every operation is keyboard-driven
- No horizontal overflow — path and match columns are constrained

## Anti-patterns avoided

No gradients, glows, pills, glass cards, shadows, or centered heroes.

## Files

- `src/file_searcher.nim` — source, ANSI-coloured console UI
- `README.md`, `DESIGN.md` — docs
- `scripts/install.sh`, `Makefile` — build/test/release
- `docs/DE.md`, `docs/ES.md` — German / Spanish
