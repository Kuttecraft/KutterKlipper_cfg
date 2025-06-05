import gi
import subprocess
gi.require_version("Gtk", "3.0")
from gi.repository import Gtk
from ks_includes.screen_panel import ScreenPanel


class Panel(ScreenPanel):
    def __init__(self, screen, title):
        title = title or _("Acción")
        super().__init__(screen, title)

        self.buttons = {}

        # Crear botón con estilo
        self.buttons["agregar_maquina"] = self._gtk.Button("home", _("Ejecutar Script"), "color4")
        self.buttons["agregar_maquina"].connect("clicked", self.ejecutar_script)

        # Tamaño y expansión
        self.buttons["agregar_maquina"].set_size_request(300, 300)
        self.buttons["agregar_maquina"].set_hexpand(True)
        self.buttons["agregar_maquina"].set_vexpand(True)

        # Contenedor principal
        main_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL)
        main_box.set_valign(Gtk.Align.FILL)
        main_box.set_halign(Gtk.Align.FILL)
        main_box.pack_start(self.buttons["agregar_maquina"], True, True, 0)

        self.content.add(main_box)

    def activate(self):
        pass

    def ejecutar_script(self, widget):
        try:
            subprocess.Popen(["bash", "/home/kutter/klipper/add_maquina.sh"])
        except Exception as e:
            print(f"Error al ejecutar el script: {e}")
