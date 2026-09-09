# omsx_menu.tcl - Vuelca la VRAM de la PANTALLA DE MENU de Hole in One
# Professional, que es la que el volcado por reloj no alcanza: el arranque se
# va a la exhibicion de los dieciocho hoyos y tarda mas de un minuto en salir.
#
# Aqui se pulsa el espacio para cortarla -0x66A0 sale con el disparo, y en el
# arranque (0xCA34) vale cero, o sea GTTRIG(0), que es la barra- y se vuelca
# despues, ya con el menu montado por 0x4072 y 0x4078.
#
# Variables de entorno:
#   HIOP_SALIDA  carpeta de salida (por defecto work/omsx-menu)

proc opcion {nombre porDefecto} {
    global env
    if {[info exists env($nombre)]} { return $env($nombre) }
    return $porDefecto
}

set ::SALIDA [opcion HIOP_SALIDA {C:/Users/Antxiko/Documents/DES_ASM/HOLEINONEPRO_DISAM/work/omsx-menu}]
file mkdir $::SALIDA
set ::n 0

proc vuelca {etiqueta} {
    set i [format %02d $::n]
    incr ::n
    set f [open $::SALIDA/vram_$i.bin w]
    fconfigure $f -translation binary
    puts -nonewline $f [debug read_block VRAM 0 16384]
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

# La barra es la fila 8, bit 0 de la matriz del teclado del MSX.
proc pulsa_espacio {} { keymatrixdown 8 0x01 }
proc suelta_espacio {} { keymatrixup 8 0x01 }

after time 10.0 { pulsa_espacio }
after time 10.3 { suelta_espacio }
after time 11.5 { vuelca menu }
after time 13.0 { vuelca menu }
after time 15.0 { vuelca menu }
after time 15.5 { exit }

after realtime 90 {
    puts {PERRO GUARDIAN a los 90 s reales}
    exit
}
