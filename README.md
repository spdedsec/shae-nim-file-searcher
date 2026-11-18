# shae-nim-file-searcher

Fast file searcher written in Nim, built on the SHAE Field Manual design
system: warm paper #F2EEE5, ink #191712, one oxide-red #B3341B signal per
view, 0px radius, 1px borders, border-defined cards, monospace metadata,
WCAG AA contrast, reduced-motion fallbacks.

## Features

- search files by name pattern in a directory tree
- search files by content (grep-style, case-insensitive)
- show results with path, size, match lines
- recursive directory traversal

## Install

Requires the Nim compiler (not available locally). Cannot compile-test locally.

```bash
# Install Nim: https://nim-lang.org/install.html

git clone https://github.com/spdedsec/shae-nim-file-searcher.git
cd shae-nim-file-searcher

nim compile -d:release -o:file_searcher src/file_searcher.nim
```

Or use the installer:

```bash
./scripts/install.sh
```

## Usage

```bash
./file_searcher name <path> <pattern>
./file_searcher content <path> <query>
```

Examples:

```bash
./file_searcher name ~/Documents .md
./file_searcher content ~/Documents "todo"
./file_searcher name . .nim
```

Output columns: Path | Size | Matches (match count, then matched lines in
oxide #B3341B).

## Design system

See `DESIGN.md`. Console rendering applies the SHAE palette via ANSI
escapes:

- Warm paper `#F2EEE5` — table rules
- Ink `#191712` — primary text
- Oxide `#B3341B` — single signal (match lines, errors)

Tables are hairline-ruled, left-aligned, monospace. No gradients, glass,
pills, or shadows.

## Build / release

```bash
make build      # nim compile -d:release
make release    # source tarball for GitHub release v0.1.0
```

The Nim compiler is required and is not available locally.

## License

MIT. See `LICENSE`.
