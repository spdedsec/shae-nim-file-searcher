# shae-nim-file-searcher (Español)

Buscador de archivos rápido en Nim, basado en el SHAE Field Manual
design system: papel cálido #F2EEE5, tinta #191712, una señal óxido
#B3341B por vista, 0px de radio, bordes de 1px, metadatos monoespaciados,
contraste WCAG AA, fallback de movimiento reducido.

## Funcionalidades

- Buscar archivos por patrón de nombre en un árbol de directorios
- Buscar archivos por contenido (estilo grep, sin distinguir mayúsculas)
- Mostrar resultados con ruta, tamaño, líneas coincidentes
- Recorrido recursivo de directorios

## Instalación

Requiere el compilador Nim (no disponible localmente). No se puede
compilar-probar localmente.

```bash
# Instalar Nim: https://nim-lang.org/install.html

git clone https://github.com/spdedsec/shae-nim-file-searcher.git
cd shae-nim-file-searcher

nim compile -d:release -o:file_searcher src/file_searcher.nim
```

## Uso

```bash
./file_searcher name <ruta> <patrón>
./file_searcher content <ruta> <consulta>
```

Ejemplos:

```bash
./file_searcher name ~/Documents .md
./file_searcher content ~/Documents "todo"
```

## Sistema de diseño

Véase `DESIGN.md`. La salida por consola usa la paleta SHAE mediante
secuencias de escape ANSI.

## Licencia

MIT. Véase `LICENSE`.
