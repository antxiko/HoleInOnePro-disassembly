# Hole in One Professional (HAL Laboratory, MSX1) - desensamblado
#
# El orden de las cosas: trazar el flujo -> generar el listado -> comprobar que
# vuelve a dar la ROM byte a byte -> las comprobaciones que el reensamblado NO
# cubre.
#
# La ROM no se distribuye. Hace falta en la raiz como holeinonepro.rom, y
# `make comprueba` verifica el sha256.

ROM      = holeinonepro.rom
SHA      = 99900247abc5cff8f12fed900e4ebf783c7a7ecf8d689b4a5cccd85a8416451e
SRC      = src
WORK     = work
ORG      = 0x4000
TITULO   = HOLE IN ONE PROFESSIONAL - HAL Laboratory - MSX1 - cartucho de 32 KB en las paginas 1 y 2

all: listado verify sanity test

$(ROM):
	@echo "=================================================================="
	@echo " Falta $(ROM), y este repositorio NO lo distribuye."
	@echo ""
	@echo " Es Hole in One Professional (HAL Laboratory, 1986), 32768 bytes exactos."
	@echo " Ponlo aqui con ese nombre. Para comprobar que es el mismo:"
	@echo "     shasum -a 256 $(ROM)"
	@echo "     $(SHA)"
	@echo "=================================================================="
	@false

comprueba: $(ROM)
	@echo "$(SHA)  $(ROM)" | shasum -a 256 -c -

# El trazado sigue el flujo desde los puntos de entrada. Los que no se pueden
# deducir estaticamente -ganchos de interrupcion, destinos de saltos
# indirectos- estan declarados en el .entries, cada uno con su justificacion.
$(WORK)/holeinonepro.trace.json: $(ROM) $(SRC)/holeinonepro.entries $(SRC)/holeinonepro.nocode
	@mkdir -p $(WORK)
	python3 tools/z80trace.py $(ROM) $(ORG) $(SRC)/holeinonepro.entries \
	        $(WORK)/holeinonepro $(SRC)/holeinonepro.nocode

trace: $(WORK)/holeinonepro.trace.json

listado: $(WORK)/holeinonepro.trace.json $(SRC)/holeinonepro.notes
	python3 tools/mkasm.py $(ROM) $(ORG) $(WORK)/holeinonepro.trace.json \
	        $(SRC)/holeinonepro.notes work/msx.sym $(SRC)/holeinonepro.asm "$(TITULO)"

# La prueba que decide si el desensamblado es fiable.
verify: $(SRC)/holeinonepro.asm $(ROM)
	@sh tools/verify_build.sh $(SRC)/holeinonepro.asm $(ROM) $(ORG)

# Lo que el reensamblado NO puede cazar: que unos datos se esten leyendo como
# codigo. El binario sale identico igual, porque los bytes no cambian; lo unico
# que cambia es lo que decimos de ellos.
sanity: $(WORK)/holeinonepro.trace.json
	@echo "=================================================================="
	@echo " ningun byte declarado como datos puede salir como codigo"
	@echo "=================================================================="
	@python3 tools/check_trace.py $(WORK)/holeinonepro.trace.json $(SRC)/holeinonepro.nocode
	@python3 tools/check_datos_como_codigo.py $(WORK) $(SRC)
	@echo "=================================================================="
	@echo " ningun punto de entrada puede caer dentro de una zona de datos"
	@echo "=================================================================="
	@python3 tools/check_entradas.py $(SRC)/holeinonepro.entries $(SRC)/holeinonepro.notes \
	        $(SRC)/holeinonepro.nocode
	@echo "=================================================================="
	@echo " ni un byte del cartucho sin asignar"
	@echo "=================================================================="
	@python3 tools/presupuesto.py $(WORK) $(SRC)

densidad:
	@python3 tools/densidad.py $(SRC)/holeinonepro.asm

test:
	@echo "=================================================================="
	@echo " Tests"
	@echo "=================================================================="
	@python3 -m unittest discover -s tests -v

# Dibuja las imagenes desde los bytes del cartucho, ejecutando en Python las
# mismas rutinas que corre el Z80.
imagenes: $(ROM)
	@mkdir -p docs/imagenes
	python3 tools/graficos.py $(ROM) $(ORG) docs/imagenes

# Y la comprobacion que decide: la VRAM montada aqui contra la del emulador.
# El volcado se saca con:
#   openmsx -machine C-BIOS_MSX1_EU -cart $(ROM) -script tools/omsx_vram.tcl
vram: $(ROM)
	python3 tools/graficos.py $(ROM) $(ORG) comprueba work/omsx

# LA WEB
#
# Bilingue: el ingles en docs/ y el castellano en docs/es/. Las paginas se
# escriben en markdown y se convierten con md2html.py; la portada la monta
# make_web.py, que declara las cifras medidas de ESTE cartucho.
web: $(ROM)
	python3 tools/graficos.py $(ROM) $(ORG) docs/imagenes
	python3 tools/md2html.py docs en
	python3 tools/md2html.py docs/es es
	python3 tools/make_web.py docs/imagenes docs/index.html en
	python3 tools/make_web.py docs/imagenes docs/es/index.html es
	python3 tools/check_enlaces.py docs

clean:
	rm -rf $(WORK)/holeinonepro.trace.json $(WORK)/holeinonepro.blocks

.PHONY: all comprueba trace listado verify sanity test densidad imagenes vram web clean
