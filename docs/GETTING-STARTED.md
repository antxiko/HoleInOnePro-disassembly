# Getting started

A commented disassembly of **Hole in One Professional**, the golf game HAL
Laboratory released for the MSX in 1986: a 32 KB cartridge mapped into pages 1
and 2 (0x4000–0xBFFF). It reassembles to the exact ROM, byte for byte, and every
one of its 32,768 bytes is accounted for.

## The cartridge is not here

No repository distributes the game. Put your own dump in the root as
`holeinonepro.rom`, 32768 bytes, sha256

    99900247abc5cff8f12fed900e4ebf783c7a7ecf8d689b4a5cccd85a8416451e

`make comprueba` verifies it.

## What you need

- **Python 3** for the tools.
- **pasmo** and **z80dasm** to reassemble and check.
- **openMSX**, only if you want to repeat the VRAM comparison.

## Reproducing it

    make comprueba    the dump's sha256
    make              trace, listing, byte-for-byte reassembly,
                      coherence checks and tests
    make densidad     how many instructions carry a comment
    make imagenes     draws the images from the ROM
    make vram         and compares them against the emulator's VRAM
    make web          regenerates this site

`make` with no arguments is what decides: if the listing does not produce the
ROM byte for byte, it fails.

## What is in the repository

    src/holeinonepro.asm       the listing, generated
    src/holeinonepro.notes     the comments, anchored to addresses
    src/holeinonepro.entries   the entry points, each with its justification
    src/holeinonepro.nocode    the ranges that are NOT code
    tools/                     the tools, all of them measurable
    tests/                     what is claimed, tied to the binary

The `.asm` is generated and regenerated. What is edited by hand are the notes: a
file of address-anchored directives, so the comments survive a re-trace.

## The VRAM comparison

This is the check that decides whether the images are worth anything. The dump
comes out of openMSX:

    openmsx -machine C-BIOS_MSX1_EU -cart holeinonepro.rom \
            -script tools/omsx_vram.tcl

and then `make vram` compares, byte for byte, the VRAM `tools/graficos.py`
builds against the real one. **13,792 of 13,792** match across patterns, colour,
sprites and name tables. The 30 bytes that differ are the figures the game
writes as it plays: the TOP, the shot counts, the hole number, the distance, the
par, the wind and the slope.
