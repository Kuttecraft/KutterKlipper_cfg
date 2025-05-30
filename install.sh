#!/bin/bash

set -e

SOURCE_IMPRESORAS="$HOME/KutterKlipper_cfg/IMPRESORAS"
SOURCE_THEME="$HOME/KutterKlipper_cfg/theme/.theme"
MACROS_SRC="$HOME/KutterKlipper_cfg/macros_kuttercraft.cfg"
COMANDO_SRC="$HOME/KutterKlipper_cfg/comando_sistema.cfg"
KLIPPER_CONF_SRC="$HOME/KutterKlipper_cfg/KlipperScreen.conf"
KLIPPER_CONF_DEST="$HOME/.config/KlipperScreen/KlipperScreen.conf"
#DEST_THEME_KUTTERCRAFT="$HOME/KlipperScreen/styles/kuttercraft"

# Verificar que las fuentes existen
if [ ! -d "$SOURCE_IMPRESORAS" ]; then
    echo "[ERROR] La carpeta $SOURCE_IMPRESORAS no existe. Abortando."
    exit 1
fi

if [ ! -d "$SOURCE_THEME" ]; then
    echo "[ERROR] La carpeta $SOURCE_THEME no existe. Abortando."
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

#echo "[INFO] Reemplazando carpeta de estilo kuttercraft..."
#if [ -d "$DEST_THEME_KUTTERCRAFT" ]; then
#  echo "[INFO] Eliminando carpeta existente: $DEST_THEME_KUTTERCRAFT"
#  chattr -i -R "$DEST_THEME_KUTTERCRAFT" 2>/dev/null || true
#  chmod -R u+rwX "$DEST_THEME_KUTTERCRAFT" 2>/dev/null || true
#  rm -rf "$DEST_THEME_KUTTERCRAFT"
#fi
#echo "[INFO] Copiando $SOURCE_THEME_KUTTERCRAFT → $DEST_THEME_KUTTERCRAFT"
#cp -r "$SOURCE_THEME_KUTTERCRAFT" "$DEST_THEME_KUTTERCRAFT"

## Corregir permisos de propiedad y escritura
#chown -R "$USER:$USER" "$DEST_THEME_KUTTERCRAFT"
#chmod -R u+rwX "$DEST_THEME_KUTTERCRAFT"


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

echo "[INFO] Reemplazando carpetas '.theme' con enlaces simbólicos..."
for BASE in "${BASES[@]}"; do
  DEST_THEME="$BASE/.theme"
  if [ -e "$DEST_THEME" ] || [ -L "$DEST_THEME" ]; then
    echo "[INFO] Eliminando: $DEST_THEME"
    rm -rf "$DEST_THEME"
  fi
  echo "[INFO] Creando enlace: $DEST_THEME → $SOURCE_THEME"
  ln -s "$SOURCE_THEME" "$DEST_THEME"
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

# KlipperScreen.conf principal
if [ -f "$KLIPPER_CONF_SRC" ]; then
  echo "[INFO] Reemplazando configuración principal de KlipperScreen..."

  if [ -e "$KLIPPER_CONF_DEST" ] || [ -L "$KLIPPER_CONF_DEST" ]; then
    echo "[INFO] Eliminando archivo existente: $KLIPPER_CONF_DEST"
    rm -f "$KLIPPER_CONF_DEST"
  fi

  echo "[INFO] Creando enlace: $KLIPPER_CONF_DEST → $KLIPPER_CONF_SRC"
  ln -s "$KLIPPER_CONF_SRC" "$KLIPPER_CONF_DEST"

  # Enlazar también en cada printer_X_data/config/
  echo "[INFO] Enlazando KlipperScreen.conf en carpetas de impresoras..."
  for BASE in "${BASES[@]}"; do
    DEST_KSC="$BASE/KlipperScreen.conf"
    if [ -e "$DEST_KSC" ] || [ -L "$DEST_KSC" ]; then
      echo "[INFO] Eliminando archivo existente: $DEST_KSC"
      rm -f "$DEST_KSC"
    fi
    echo "[INFO] Enlazando $DEST_KSC → $KLIPPER_CONF_SRC"
    ln -s "$KLIPPER_CONF_SRC" "$DEST_KSC"
  done
else
  echo "[WARN] KlipperScreen.conf no encontrado en $KLIPPER_CONF_SRC — se omite."
fi

echo "[✅] Todos los enlaces y archivos fueron aplicados correctamente."
