# shae-nim-file-searcher (Deutsch)

Schneller Datei-Sucher in Nim, nach dem SHAE Field Manual Design System:
warmes Papier #F2EEE5, Tinte #191712, ein Oxid-Rot #B3341B als einziges
Signal pro Ansicht, 0px Radius, 1px Rahmen, Monospace-Metadaten,
WCAG-AA-Kontrast, reduzierte-Bewegung-Fallbacks.

## Funktionen

- Dateien nach Namensmuster im Verzeichnisbaum suchen
- Dateien nach Inhalt suchen (grep-artig, groß-/kleinschreibungsunabhängig)
- Ergebnisse mit Pfad, Größe, Trefferzeilen anzeigen
- Rekursive Verzeichnisdurchquerung

## Installation

Erfordert den Nim-Compiler (nicht lokal verfügbar). Kann nicht lokal
kompiliert-getestet werden.

```bash
# Nim installieren: https://nim-lang.org/install.html

git clone https://github.com/spdedsec/shae-nim-file-searcher.git
cd shae-nim-file-searcher

nim compile -d:release -o:file_searcher src/file_searcher.nim
```

## Verwendung

```bash
./file_searcher name <pfad> <muster>
./file_searcher content <pfad> <suchbegriff>
```

Beispiele:

```bash
./file_searcher name ~/Documents .md
./file_searcher content ~/Documents "todo"
```

## Design-System

Siehe `DESIGN.md`. Die Konsolenausgabe nutzt die SHAE-Palette über
ANSI-Escape-Sequenzen.

## Lizenz

MIT. Siehe `LICENSE`.
