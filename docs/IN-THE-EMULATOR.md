# In the emulator

What was measured with openMSX, and what for.

## What it was used for

For one thing, but the one that decides: **checking that the images on this site
are not an interpretation**. They are all drawn by running in Python the same
decompressors and the same interpreters the Z80 runs. If any of them were
misunderstood, what came out would be noise — or, worse, something that looks
right and is wrong. The only way to know is to take the real VRAM and compare.

## How

`tools/omsx_vram.tcl` sets **no breakpoints**: the dumps go by emulated clock, so
they do not depend on which instruction the emulator happens to stop at.

    openmsx -machine C-BIOS_MSX1_EU -cart holeinonepro.rom \
            -script tools/omsx_vram.tcl

It takes five dumps of the 16 KB of VRAM and, with each, the VDP's eight
registers and a screenshot. Then:

    make vram

## What the registers say

    02 E2 06 FF 03 36 07 F1

which is exactly what the code says it builds:

| register | value | what |
|---|---|---|
| R2 | 06 | name table at 0x1800 |
| R3 | FF | colour table at 0x2000 |
| R4 | 03 | pattern table at 0x0000 |
| R5 | 36 | sprite attributes at 0x1B00 |
| R6 | 07 | sprite patterns at 0x3800 |

## The result

| area | different | of |
|---|---|---|
| patterns, third 0 | 0 | 2,048 |
| patterns, third 1 | 0 | 2,048 |
| patterns, third 2 | 0 | 2,048 |
| colour, third 0 | 0 | 2,048 |
| colour, third 1 | 0 | 2,048 |
| colour, third 2 | 0 | 2,048 |
| sprite patterns | 0 | 736 |
| name table at 0x3C00 | 0 | 768 |
| **total** | **0** | **13,792** |

Zero differences across everything that comes out of a table.

## The thirty bytes that do differ

In the left-hand panel there are 30 bytes different out of 264, and they are
exactly the ones the game writes as it plays:

    what this repo builds       what is in the emulator
    *TOP    +!                  *TOP ;18+!        -> TOP +18
    *1UP    +!                  *1UP  <0+!        -> 1UP ±0
    * 1UP   +!                  * 1UP  0+!        -> SHOTS 1UP 0
    *HOLE   +!                  *HOLE  1+!        -> HOLE 1
    *     ? +!                  * 352 ? +!        -> 352 m
    * PAR   +#                  * PAR 4 +#        -> PAR 4

That is: the factory TOP, both players' shot counts, the hole number, the
distance, the par, the wind and the slope. None of them is in a table, which is
why they are not compared.

And they double as another check: the **352 metres** and the **par 4** the
emulator shows are the ones `tools/campos.py` gets out of the script for hole 1
of QUEEN SIDE, reading the par off the tee tile and the metres off the three
ASCII digits that close the script.

## What was NOT measured in the emulator

- **The sound.** The twelve tracks are followed byte by byte with the
  cartridge's own interpreter and their boundaries are measured, but nobody has
  listened to them against what the real PSG does.
- **The editor.** Its labels, stamps and file format come out of the code; no
  course has been saved and loaded back.
- **The opponent.** That it rehearses the shot is read off the code, not timed.

It is said in [Open questions](OPEN-QUESTIONS.html).
