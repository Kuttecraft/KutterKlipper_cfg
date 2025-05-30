# 🎨 KutterKlipper_cfg

Una herramienta de personalización visual para tu entorno Klipper + Mainsail + KlipperScreen.  
Este plugin agrega un **tema visual único** que transforma la experiencia de usuario con un diseño más elegante y moderno.

---

## 📦 Requisitos

Antes de instalar este plugin, asegurate de tener:

✅ [Klipper](https://www.klipper3d.org/)  
✅ [KlipperScreen](https://github.com/jordanruthe/KlipperScreen)  
✅ [Mainsail](https://docs.mainsail.xyz/)

🔄 Además, se requiere tener **cuatro instancias** de Klipper y Mainsail correctamente configuradas y funcionando.

---

## 🚀 Instalación

1. Clona el repositorio y ejecuta el script de instalación:
```bash
git clone https://github.com/Kuttecraft/KutterKlipper_cfg.git
cd KutterKlipper_cfg
chmod +x install.sh
./install.sh
```

2. Para mantenerlo actualizado, agrega el script de actualización a moonraker.conf:
```bash
[update_manager KutterKlipper_cfg]
type: git_repo
install_script: /home/kutter/KutterKlipper_cfg/install.sh
primary_branch: main
path: ~/KutterKlipper_cfg
origin: https://github.com/Kuttecraft/KutterKlipper_cfg.git
managed_services: klipper
```

---

## 🛠️ Soporte y mantenimiento
Este proyecto está en constante evolución. Si encontrás errores o tenés ideas de mejora, podés abrir un [issue aquí](https://github.com/Kuttecraft/KutterKlipper_cfg/issues).

---

## 💡 Autor
Creado con ❤️ por Kuttecraft.