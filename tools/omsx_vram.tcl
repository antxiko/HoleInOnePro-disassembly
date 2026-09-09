# omsx_vram.tcl - Vuelca la VRAM de verdad de Hole in One Professional, para
# comprobar contra ella lo que tools/graficos.py monta en Python. Si los dos
# descompresores, el interprete de texto y el de guiones estan bien entendidos,
# los bytes tienen que coincidir; si no, no.
#
# No pone NINGUN punto de ruptura: los volcados van por reloj emulado, para
# que no dependan de en que instruccion se para el emulador.
#
# Variables de entorno:
#   HIOP_SALIDA  carpeta de salida (por defecto work/omsx)

proc opcion {nombre porDefecto} {
    global env
    if {[info exists env($nombre)]} { return $env($nombre) }
    return $porDefecto
}

set ::SALIDA [opcion HIOP_SALIDA {C:/Users/Antxiko/Documents/DES_ASM/HOLEINONEPRO_DISAM/work/omsx}]
file mkdir $::SALIDA
set ::n 0

proc vuelca {etiqueta} {
    set i [format %02d $::n]
    incr ::n
    set datos [debug read_block VRAM 0 16384]
    set f [open $::SALIDA/vram_$i.bin w]
    fconfigure $f -translation binary
    puts -nonewline $f $datos
    close $f
    set r {}
    for {set k 0} {$k < 8} {incr k} {
        lappend r [format %02X [debug read {VDP regs} $k]]
    }
    set f [open $::SALIDA/info_$i.txt w]
    puts $f [format {etiqueta %s} $etiqueta]
    puts $f [format {tiempo %s} [machine_info time]]
    puts $f [format {regs %s} [join $r { }]]
    close $f
    catch { screenshot -raw $::SALIDA/pant_$i.png }
}

# El arranque monta la pantalla, decomprime patrones y color, escribe el panel
# y arranca la exhibicion de los dieciocho hoyos. A los pocos segundos ya esta
# todo en la VRAM.
after time  2.0 { vuelca arranque }
after time  4.0 { vuelca creditos }
after time  8.0 { vuelca exhibicion }
after time 14.0 { vuelca exhibicion }
after time 20.0 { vuelca menu }
after time 20.5 { exit }

after realtime 90 {
    puts {PERRO GUARDIAN a los 90 s reales}
    exit
}
