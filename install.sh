#!/bin/bash

set -e

SOURCE_IMPRESORAS="$HOME/KutterKlipper_cfg/IMPRESORAS"
MACROS_SRC="$HOME/KutterKlipper_cfg/macros_kuttercraft.cfg"
COMANDO_SRC="$HOME/KutterKlipper_cfg/comando_sistema.cfg"

# Verificar que las fuentes existen
if [ ! -d "$SOURCE_IMPRESORAS" ]; then
    echo "[ERROR] La carpeta $SOURCE_IMPRESORAS no existe. Abortando."
    exit 1
fi

if [ ! -f "$MACROS_SRC" ]; then
    echo "[ERROR] El archivo $MACROS_SRC no existe. Abortando."
    exit 1
fi

if [ ! -f "$COMANDO_SRC" ]; then
    echo "[ERROR] El archivo $COMANDO_SRC no existe. Abortando."
    exit 1
fi

# Lista de rutas base
BASES=(
  "$HOME/printer_1_data/config"
  "$HOME/printer_2_data/config"
  "$HOME/printer_3_data/config"
  "$HOME/printer_4_data/config"
)

echo "[INFO] Reemplazando carpetas 'impresoras' con enlaces simbólicos..."
for BASE in "${BASES[@]}"; do
  DEST_IMPRESORAS="$BASE/impresoras"
  if [ -e "$DEST_IMPRESORAS" ] || [ -L "$DEST_IMPRESORAS" ]; then
    echo "[INFO] Eliminando: $DEST_IMPRESORAS"
    rm -rf "$DEST_IMPRESORAS"
  fi
  echo "[INFO] Creando enlace: $DEST_IMPRESORAS → $SOURCE_IMPRESORAS"
  ln -s "$SOURCE_IMPRESORAS" "$DEST_IMPRESORAS"
done

echo "[INFO] Reemplazando archivos 'macros_kuttercraft.cfg'..."
for BASE in "${BASES[@]}"; do
  DEST_MACROS="$BASE/macros_kuttercraft.cfg"
  if [ -f "$DEST_MACROS" ]; then
    echo "[INFO] Eliminando archivo existente: $DEST_MACROS"
    rm -f "$DEST_MACROS"
  fi
  echo "[INFO] Copiando $MACROS_SRC → $DEST_MACROS"
  cp "$MACROS_SRC" "$DEST_MACROS"
  chmod 644 "$DEST_MACROS"
done

echo "[INFO] Reemplazando archivos 'comando_sistema.cfg' con enlaces simbólicos..."
for BASE in "${BASES[@]}"; do
  DEST_COMANDO="$BASE/comando_sistema.cfg"
  if [ -e "$DEST_COMANDO" ] || [ -L "$DEST_COMANDO" ]; then
    echo "[INFO] Eliminando archivo existente: $DEST_COMANDO"
    rm -f "$DEST_COMANDO"
  fi
  echo "[INFO] Creando enlace: $DEST_COMANDO → $COMANDO_SRC"
  ln -s "$COMANDO_SRC" "$DEST_COMANDO"
done

echo "[OK] Todos los enlaces y archivos fueron aplicados correctamente."
