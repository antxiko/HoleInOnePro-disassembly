# The code

How the listing is made and why you can trust it.

## The listing is generated

Nobody edits the `.asm`. `tools/mkasm.py` generates it from three things:

- the **flow trace** (`tools/z80trace.py`), which follows the code from the
  entry points and marks which bytes are instructions;
- the **notes** file, with comments anchored to addresses;
- and the declared **data ranges**, so the tracer does not wander into them.

That way the comments survive a re-trace: if tomorrow a block turns out to be
code, you re-trace and the comments stay where they were.

## What decides: reassembling

    make verify

assembles the listing with pasmo and compares the result to the ROM. Byte for
byte, the same sha256. Without that, everything else is decoration.

## What reassembling does NOT catch

Reassembling cannot tell bytes read as code from the same bytes read as data:
the binary comes out the same. So there are three more checks:

- **no range declared as data may come out as code**;
- **no entry point may fall inside a data range**;
- and the **budget**: each of the 32,768 bytes has to be either reached code or
  a named, explained data block. Right now, **none unaccounted for**.

## The entry points that cannot be deduced

Static tracing does not reach everything. The ones that have to be declared by
hand live in `src/holeinonepro.entries`, each with its justification:

- **0x665B**, the interrupt handler, because the H.TIMI hook is an inter-slot
  call and not a jump.
- **The ten entries of the table at 0xAFAD**, which two `jp (hl)` use to
  dispatch the editor's states.
- **The eight little menu routines** (0x40E6–0x4116), which are not reached by
  a jump: 0x40A6 pulls the address out of a table, pushes it and does a `ret`.
- **The four in the table at 0xB2A4**, the tile-picker submenu.
- **Three routines in the tape section** (0xBE0E, 0xBE63, 0xBE7C), reached by
  pushing them onto the stack.
- And **0xB885**, which nobody calls: it is dead code, declared so that it comes
  out disassembled and can be read.

## The numbers

| | |
|---|---|
| traced code | 14,186 bytes (43.3%) |
| identified data | 18,582 bytes (56.7%) |
| unaccounted for | **0** |
| instructions | 7,133 |
| line comments | 3,169 |
| density | **44.4%** |
| routines below 10% | **0** |
| `call` targets left unnamed | **0** |

The last three are the series' bar, and all three are cleared.

## The arithmetic library

Between 0x6485 and 0x6564 there is a small, well-made library, and at 0x6564 the
routine that builds its tables in RAM at boot:

- **squares**: 0xC200 and 0xC300, the squares of 0 to 255 in two bytes. They are
  computed by calling the multiply 256 times.
- **square root** (0x64A2): a bit-by-bit binary search against that same table.
- **arctangent**: 0xC500–0xC600, 256 entries with values from 0 to 32, that is,
  0 to 45 degrees. In the ROM it is **run-length compressed**: thirty-three
  counts at 0x65A2 that add up to exactly 256.
- **sine and cosine**: 0xC400–0xC500. In the ROM there is a 64-byte quarter wave
  (0x65C3) which 0x658C reads **backwards** while writing both upwards and
  downwards — mirroring it — and then copies the two halves.
- **signed multiply** (0x651F and 0x6524), 8×8 to 16 bits.

That is enough for everything: the angle between two points, the distance, the
decomposition of a velocity into its two components, and friction.

## The sound

Twelve PSG tracks, with the pointer table at 0x6B55 and the interpreter at
0x6B83, which runs once per interrupt.

The rules, read off the code: a byte with bit 7 or bit 6 set is a **note** — the
bottom six bits index, doubled, the tone table at 0x6C0D; with bit 5 clear it is
a **wait** in frames; and the rest are commands: `0x2D` stores the envelope
shape, `0x33` is a **jump**, `0x3D` is the **stop** and `0x3E` zeroes registers
0 to 5.

Where each track ends is not written down. Following them with that same
interpreter (`tools/pistas.py`) gives twelve runs that fit without a gap, and two
things turn up: **five tracks share a tail** — 5 runs into 6, 6 into 0, 0 into 1,
1 into 7, and all five end at the same stop at 0x6D7A — and **track 11 is the
only one that loops**, because it ends in a jump to itself. The highest note the
twelve use is 43, which is exactly where the tone table ends.

> This reading reproduces the cartridge's interpreter, but it is **not**
> corroborated against the emulator. The boundaries are measured; that it sounds
> like what is described here is not claimed.
