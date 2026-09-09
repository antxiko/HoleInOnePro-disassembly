# Hole in One Professional — a commented disassembly

[Read this in Spanish / Leer en castellano](README.es.md) &middot;
**[The website](https://antxiko.github.io/HoleInOnePro-disassembly/)**

A complete, commented disassembly of **Hole in One Professional** (HAL
Laboratory, MSX, 1986): a 32 KB cartridge mapped into pages 1 and 2. It
reassembles to the exact ROM, byte for byte, and every one of its 32,768 bytes
is accounted for.

| | |
|---|---|
| binary explained | **100 %** |
| traced code | 14,186 bytes |
| identified data | 18,582 bytes |
| unaccounted for | **0** |
| instructions | 7,133 |
| line comments | 3,169 |
| comment density | **44.4 %** |
| routines below 10 % | **0** |
| `call` targets left unnamed | **0** |
| VRAM checked against openMSX | **28,240 of 28,240** |
| tests | 26 |

## The cartridge is not here

No repository distributes the game. Put your own dump in the root as
`holeinonepro.rom`, 32768 bytes, sha256

    99900247abc5cff8f12fed900e4ebf783c7a7ecf8d689b4a5cccd85a8416451e

`make comprueba` verifies it.

## Reproducing it

    make comprueba    the dump's sha256
    make              trace, listing, byte-for-byte reassembly, checks, tests
    make densidad     how many instructions carry a comment
    make imagenes     draws the images from the ROM
    make vram         compares them against the emulator's VRAM
    make web          regenerates the website

## What turned up

- **The opponent does not compute its shot: it rehearses it.** 0x5BB4 plays the
  whole shot with the real physics, looks at where the ball landed, changes club,
  power, curve or aim and hits it again — until it likes the result. Only then
  is it replayed in front of the player.
- **The terrain is decided by the pixel**, not by the tile: 0x63B1 reads the
  exact bit under the ball out of the VRAM pattern table and 0x63D3 its colour
  nibble.
- **Golf's honour rule is in the code**: 0x46FA measures both distances and lets
  the player farther from the hole play first.
- **Three whole screens at once in VRAM** (0x1800, 0x1C00 and 0x3C00), switched
  by flipping VDP register 2.
- **Thirty-five real tour professionals** at 0x5009 — Nicklaus, Ballesteros,
  Trevino, Watson, Norman, Aoki, both Ozakis — with the terminator in bit 7 of
  the last character.
- **A full course editor inside** (`GAME >>CONSTRUCTION`), which is the CONST
  program from the 1985 *Hole In One Extension Course* tape: 3,050 shared bytes.
- **And the file it saves is the 1984 cartridge's**: the same twenty-one-byte
  header and the same offsets, so a course built here loads into the 1984
  *Hole in One* with `CALL GOLF`.

There is more, with addresses, on
[the website](https://antxiko.github.io/HoleInOnePro-disassembly/).

## Licence

The tools, the comments and the documentation are MIT (see `LICENSE`). The game
is not: its code, graphics and sound remain with their authors and with HAL
Laboratory. See `LEGAL-NOTICE.md`.
