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

        # Primer botón
        self.buttons["agregar_maquina"] = self._gtk.Button("mas", _("Agregar Impresora 01"), "color4")
        #self.buttons["agregar_maquina"].set_size_request(300, 300)
        self.buttons["agregar_maquina"].set_hexpand(True)
        self.buttons["agregar_maquina"].set_vexpand(True)
        self.buttons["agregar_maquina"].connect("clicked", self.ejecutar_script_agregar)

        # Segundo botón
        self.buttons["actualizar_firmware"] = self._gtk.Button("mas", _("Agregar Impresora 02"), "color2")
        #self.buttons["actualizar_firmware"].set_size_request(300, 300)
        self.buttons["actualizar_firmware"].set_hexpand(True)
        self.buttons["actualizar_firmware"].set_vexpand(True)
        self.buttons["actualizar_firmware"].connect("clicked", self.ejecutar_script_actualizar)

        # Tercer botón
        self.buttons["reiniciar_servicio"] = self._gtk.Button("mas", _("Agregar Impresora 03"), "color1")
        #self.buttons["reiniciar_servicio"].set_size_request(300, 300)
        self.buttons["reiniciar_servicio"].set_hexpand(True)
        self.buttons["reiniciar_servicio"].set_vexpand(True)
        self.buttons["reiniciar_servicio"].connect("clicked", self.ejecutar_script_reiniciar)

        # Cuarto botón
        self.buttons["config_extra"] = self._gtk.Button("mas", _("Agregar Impresora 04"), "color3")
        #self.buttons["config_extra"].set_size_request(300, 300)
        self.buttons["config_extra"].set_hexpand(True)
        self.buttons["config_extra"].set_vexpand(True)
        self.buttons["config_extra"].connect("clicked", self.ejecutar_script_config)

        # Contenedor en cuadrícula 2x2
        grid = Gtk.Grid(row_spacing=10, column_spacing=10)
        grid.set_valign(Gtk.Align.FILL)
        grid.set_halign(Gtk.Align.FILL)

        grid.attach(self.buttons["agregar_maquina"], 0, 0, 1, 1)
        grid.attach(self.buttons["actualizar_firmware"], 1, 0, 1, 1)
        grid.attach(self.buttons["reiniciar_servicio"], 0, 1, 1, 1)
        grid.attach(self.buttons["config_extra"], 1, 1, 1, 1)

        self.content.add(grid)

    def activate(self):
        pass

    def ejecutar_script_agregar(self, widget):
        self._run_script("/home/kutter/klipper/add_maquina.sh")

    def ejecutar_script_actualizar(self, widget):
        self._run_script("/home/kutter/klipper/update_firmware.sh")

    def ejecutar_script_reiniciar(self, widget):
        self._run_script("/home/kutter/klipper/restart_service.sh")

    def ejecutar_script_config(self, widget):
        self._run_script("/home/kutter/klipper/extra_config.sh")

    def _run_script(self, path):
        try:
            subprocess.Popen(["bash", path])
        except Exception as e:
            print(f"Error al ejecutar el script {path}: {e}")
