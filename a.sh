#!/bin/bash

set -e

SOURCE_IMPRESORAS="$HOME/KutterKlipper_cfg/IMPRESORAS"
SOURCE_THEME="$HOME/KutterKlipper_cfg/theme/.theme"
MACROS_SRC="$HOME/KutterKlipper_cfg/macros_kuttercraft.cfg"
COMANDO_SRC="$HOME/KutterKlipper_cfg/comando_sistema.cfg"
KLIPPER_CONF_SRC="$HOME/KutterKlipper_cfg/KlipperScreen.conf"
KLIPPER_CONF_DEST="$HOME/.config/KlipperScreen/KlipperScreen.conf"
/KlipperScreen/styles/kuttercraft="$HOME/KlipperScreen/styles/kuttercraft"
SOURCE_THEME_KUTTERCRAFT="$HOME/KutterKlipper_cfg/theme/kuttercraft"
SOURCE_DIR_THEME_KUTTERCRAFT="$HOME/KlipperScreen/styles/"

echo "[INFO] Reemplazando carpeta de estilo kuttercraft..."
if [ -d "$/KlipperScreen/styles/kuttercraft" ]; then
  echo "[INFO] Eliminando carpeta existente: $/KlipperScreen/styles/kuttercraft"
  chattr -i -R "$/KlipperScreen/styles/kuttercraft" 2>/dev/null || true
  chmod -R u+rwX "$/KlipperScreen/styles/kuttercraft" 2>/dev/null || true
  rm -rf "$/KlipperScreen/styles/kuttercraft"
fi
echo "[INFO] Copiando /KutterKlipper_cfg/theme/kuttercraft" → $/KlipperScreen/styles/kuttercraft"
cp -r /KutterKlipper_cfg/theme/kuttercraft" "$/KlipperScreen/styles/kuttercraft"

# Corregir permisos de propiedad y escritura
chown -R "$USER:$USER" "$/KlipperScreen/styles/kuttercraft"
chmod -R u+rwX "$/KlipperScreen/styles/kuttercraft"
