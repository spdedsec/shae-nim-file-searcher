# shae-nim-file-searcher
# ----------------------
# Fast file searcher written in Nim, built on the SHAE Field Manual
# design system.
#
# Features:
#   - search files by name pattern in a directory tree
#   - search files by content (grep-style)
#   - show results with path, size, match lines
#   - recursive directory traversal
#
# Requires: nim compiler (not available locally). Cannot compile-test locally.
#
# Build: nim compile -d:release src/file_searcher.nim
# Run:   ./file_searcher <mode> <path> [pattern|query]
#
# Design system (SHAE Field Manual): console output uses the paper
# #F2EEE5, ink #191712, oxide #B3341B palette via ANSI escapes; tables
# are hairline-ruled, left-aligned, monospace metadata; no gradients,
# glass, pills, shadows.

import os, strutils, sequtils, strformat

const
  ANSI_RESET   = "\e[0m"
  ANSI_INK     = "\e[38;2;25;23;18m"    # #191712
  ANSI_OXIDE   = "\e[38;2;179;52;27m"   # #B3341B
  ANSI_PAPER   = "\e[38;2;242;238;229m" # #F2EEE5
  ANSI_BOLD    = "\e[1m"

type
  SearchResult = object
    path: string
    size: int64
    matches: seq[string]

proc humanSize(bytes: int64): string =
  var
    size = float64(bytes)
    units = @["B", "KB", "MB", "GB", "TB"]
    i = 0
  while size >= 1024.0 and i < high(units):
    size /= 1024.0
    inc(i)
  result = format("{0:.2f} {1}", [size, units[i]])

proc renderTable(title: string, rows: seq[SearchResult]) =
  echo ANSI_BOLD & ANSI_INK & title & ANSI_RESET
  echo ANSI_PAPER & "--------------------------------------------------------------------------------" & ANSI_RESET
  echo ANSI_INK & format(" %-60s | %-10s | {}", ["Path", "Size", "Matches"]) & ANSI_RESET
  echo ANSI_PAPER & "--------------------------------------------------------------------------------" & ANSI_RESET
  if rows.len == 0:
    echo ANSI_OXIDE & "  No results." & ANSI_RESET
  else:
    for r in rows:
      let matchCount = if r.matches.len > 0: $r.matches.len else "-"
      echo format(" %-60s | %-10s | {}", [r.path, humanSize(r.size), matchCount])
      if r.matches.len > 0:
        for m in r.matches:
          echo format("      {} {}", ANSI_OXIDE, m & ANSI_RESET)
  echo ANSI_PAPER & "--------------------------------------------------------------------------------" & ANSI_RESET

proc searchByName(root: string, pattern: string): seq[SearchResult] =
  var results: seq[SearchResult] = @[]
  walkDir(root, proc(p: string, isDir: bool) =
    if not isDir and p.endsWith(pattern):
      let size = fileSize(p)
      results.add(SearchResult(path: p, size: size, matches: @[]))
  )
  return results

proc searchByContent(root: string, query: string): seq[SearchResult] =
  var results: seq[SearchResult] = @[]
  walkDir(root, proc(p: string, isDir: bool) =
    if not isDir:
      var matches: seq[string] = @[]
      try:
        let lines = readLines(p)
        for line in lines:
          if line.contains(query, ignoreCase = true):
            matches.add(line.strip())
      except:
        discard  # skip unreadable/binary files
      if matches.len > 0:
        results.add(SearchResult(path: p, size: fileSize(p), matches: matches))
  )
  return results

proc printUsage() =
  echo ANSI_BOLD & ANSI_INK & "shae-nim-file-searcher" & ANSI_RESET
  echo ANSI_PAPER & "----------------------------------------" & ANSI_RESET
  echo "  name <path> <pattern>   search files by name pattern"
  echo "  content <path> <query>  search files by content (grep-style)"
  echo ""
  echo "Design system: paper #F2EEE5, ink #191712, oxide #B3341B"

when isMainModule:
  let params = commandLineParams()
  if params.len < 3:
    printUsage()
    quit(1)

  let mode   = params[0]
  let root   = params[1]
  let term   = params[2]

  if not dirExists(root):
    echo ANSI_OXIDE & "Error: directory not found: " & root & ANSI_RESET
    quit(1)

  let results = case mode
    of "name":   searchByName(root, term)
    of "content": searchByContent(root, term)
    else:
      echo ANSI_OXIDE & "Error: unknown mode '" & mode & "' (use 'name' or 'content')" & ANSI_RESET
      quit(1)

  let title = if mode == "name":
    format("Name search: {} in {}", [term, root])
  else:
    format("Content search: '{}' in {}", [term, root])

  renderTable(title, results)
  echo ANSI_INK & format("{} result(s).", [results.len]) & ANSI_RESET
