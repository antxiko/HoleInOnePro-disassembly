# omsx_titulo.tcl - Barre el arranque entero volcando VRAM y captura cada medio
# segundo, para encontrar la PANTALLA DE TITULO: la que lleva el rotulo grande.
#
# Los volcados por reloj del primer barrido cayeron todos dentro de la
# exhibicion de los dieciocho hoyos, asi que el titulo no aparecio. Aqui se
# mira desde el primer segundo.
#
#   HIOP_SALIDA  carpeta de salida (por defecto work/omsx-titulo)

proc opcion {nombre porDefecto} {
    global env
    if {[info exists env($nombre)]} { return $env($nombre) }
    return $porDefecto
}

set ::SALIDA [opcion HIOP_SALIDA {C:/Users/Antxiko/Documents/DES_ASM/HOLEINONEPRO_DISAM/work/omsx-titulo}]
file mkdir $::SALIDA

proc vuelca {t} {
    set i [format %04.1f $t]
    set f [open $::SALIDA/vram_$i.bin w]
    fconfigure $f -translation binary
    puts -nonewline $f [debug read_block VRAM 0 16384]
    close $f
    set r {}
    for {set k 0} {$k < 8} {incr k} {
        lappend r [format %02X [debug read {VDP regs} $k]]
    }
    set f [open $::SALIDA/info_$i.txt w]
    puts $f [format {tiempo %s} [machine_info time]]
    puts $f [format {regs %s} [join $r { }]]
    close $f
    catch { screenshot -raw $::SALIDA/pant_$i.png }
}

for {set t 5} {$t <= 240} {incr t 5} {
    set s [expr {$t / 10.0}]
    after time $s [list vuelca $s]
}
after time 24.5 { exit }

after realtime 120 {
    puts {PERRO GUARDIAN a los 120 s reales}
    exit
}
