#!/bin/bash

set -e

SOURCE_PATH="$HOME/KutterKlipper_cfg/IMPRESORAS"
MACROS_SRC="$HOME/KutterKlipper_cfg/macros_kuttercraft.cfg"

# Verificamos que la carpeta de origen existe
if [ ! -d "$SOURCE_PATH" ]; then
    echo "[ERROR] La carpeta $SOURCE_PATH no existe. Abortando."
    exit 1
fi

# Verificamos que el archivo de macros existe
if [ ! -f "$MACROS_SRC" ]; then
    echo "[ERROR] El archivo $MACROS_SRC no existe. Abortando."
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

  echo "[INFO] Creando enlace: $DEST_IMPRESORAS → $SOURCE_PATH"
  ln -s "$SOURCE_PATH" "$DEST_IMPRESORAS"
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

echo "[OK] Enlaces y archivos macros actualizados correctamente."
