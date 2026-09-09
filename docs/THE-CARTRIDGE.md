# The cartridge

32,768 bytes mapped into pages 1 and 2, that is, 0x4000 to 0xBFFF.

## The header

The first ten bytes are the MSX's AB header:

    41 42 10 40 00 00 00 00 00 00
    'A''B' INIT  STATEMENT  DEVICE  TEXT

It **only declares INIT**, at 0x4010. STATEMENT, DEVICE and TEXT are zero, and
that is precisely what separates this cartridge from the 1984 *Hole in One*:
that one registered a BASIC statement — `CALL GOLF` — and could therefore load
courses from tape. This one does not. Outside courses get in another way: through
the editor.

## The layout

| from | to | what |
|---|---|---|
| 0x4000 | 0x4010 | the AB header |
| 0x4010 | 0x5009 | boot, menu, scorecard and the round loop |
| 0x5009 | 0x5175 | the thirty-five golfers and their tables |
| 0x5175 | 0x52DE | the title screen's texts |
| 0x52DE | 0x63E9 | the shot: aim, bars, flight and physics |
| 0x63E9 | 0x6603 | terrain, arithmetic and the trigonometry tables |
| 0x6603 | 0x6C0D | screen, interrupt, joystick and the PSG player |
| 0x6C0D | 0x6F49 | the tone table and the twelve tracks |
| 0x6F49 | 0x716B | the hole builder |
| 0x716B | 0x9DDD | **the two courses**: 36 pointers, 36 scripts and the green |
| 0x9DDD | 0x9F85 | the close-up view and the swing |
| 0x9F85 | 0xAEA3 | everything that decompresses into VRAM |
| 0xAEA3 | 0xC000 | **the course editor** and the tape code |

In numbers: **14,186 bytes of traced code** and **18,582 of named data**. None
unaccounted for.

## How it boots

`init` (0x4010) does the usual and one thing more. First it works out which slot
it is in itself — RSLREG, the subslot table at 0xFCC1 — and **stores the result
at 0xFEDB**. It will need that note much later, when the tape routine swaps page
1 for the BASIC ROM and has to put it back.

Then it pages its own second half into page 2 with ENASLT, clears 0xC002–0xF300
in one go, leaves QUEEN SIDE as the default course and the TOP at 0x12 —
eighteen, one over par on every hole — starts the PSG, hooks the interrupt and
goes off to the attract mode.

## The interrupt, across slots

0x6603 does not put a `jp` into H.TIMI: it puts an **inter-slot call**.

    ld a,0f7h        ; 0xF7 is RST 30h, that is, CALSLT
    ld (0fd9fh),a
    ld a,(0fedbh)    ; the slot, the one init noted down
    ld (0fda0h),a
    ld hl,0665bh     ; and the address
    ld (0fda1h),hl

It has to be that way because the handler lives inside the cartridge, and when
the interrupt fires there is no guarantee the cartridge is paged in. The handler
(0x665B) does two things: it marks that a frame has passed, and it gives the PSG
player one step.

## Three screens in VRAM

The MSX's SCREEN 2 has one name table, but VDP register 2 says where it is. This
cartridge builds three and flips that register:

| address | what it is | how you get there |
|---|---|---|
| 0x1800 | the playing screen | the default, R2=0x06 |
| 0x1C00 | the eighteen-hole scorecard | 0x678B, `xor 1` |
| 0x3C00 | the tournament leaderboard | 0x67CC, `xor 9` |

Pressing F1 or F2 mid-round redraws nothing. It shows another screen that was
already built, and letting go returns to the previous one.

## The three thirds, from a single table

SCREEN 2 is three independent thirds, and for all three to hold the same thing
you have to write it three times. 0x66D4 makes the six calls — three of patterns
and three of colour — and all three of each kind decompress **the same source**:
2 KB of cartridge for 6 KB of table.

And there is a second loading mode hidden in the same place. 0x66D4 begins with
an `or 0AFh`, which is the two bytes `F6 AF`. Entering at **0x66D5** — the second
byte of that instruction — what runs is a bare `xor a`: A goes to zero, Z is set
and the six calls load only the tail of each third, the 360 bytes that carry the
font, instead of the whole third. 0x6788 uses it to restore the lettering after
showing the scorecard, without repainting the graphics.

## The eleven compressed blocks

There are two decompressors, told apart by their escape byte:

- **0x6AFA**, run-length: `0xA0`–`0xAF` means (n & 0x0F) + 2 copies of the next
  byte.
- **0x6ABD**, pairs: `0x00`–`0x0F` means (n & 0x0F) + 1 rounds of a **pair** of
  alternating bytes. This is the one for SCREEN 2's colour tables, where bytes
  come in pairs.

Both stop when the **destination** reaches its limit, not when the input runs
out. So where each block ends is written down nowhere: you find out by
decompressing it. Do that, and the eleven fit one after another **without a byte
to spare**, from 0x9F85 to 0xAEA3. It is the best evidence the format is
understood, and there is a test watching it.
