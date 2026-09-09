# The editor

`GAME >>CONSTRUCTION` is not a game mode: it is a full **course editor**, and it
runs from 0xAEA3 to the end of the cartridge. With it you draw eighteen holes,
measure their length, try them by actually hitting a ball, and save them to tape.

## Where it comes from

From the tape. In 1985 HAL released *Hole In One Extension Course*, and besides
three courses it carried a file called **CONST**: 12 KB of program that are this
same editor. The strings inside leave no room for doubt — SETCHR, SET=UP, MOVE,
SWAP, CLEAR, SAVE1, SAVE18, LOAD, FILES, DEVICE, NAME:, "GREEN OR TEE NOT FOUND"
— and this cartridge **shares 3,050 bytes with it across 24 runs**, including the
club table at 0x4B16 and the whole sprite sheet.

So the 1985 editor went inside the 1986 cartridge.

## Three screens

(0xCED9) says which one you are on, and each has its own cursor — 0xCEDA, 0xCEDB
and 0xCEDC. IY points at the right one.

| screen | options |
|---|---|
| 0 | HOLE · SETCHR · PAR · DIST. · SHOT · MOVE · WIND |
| 1 | the drawing one |
| 2 | SAVE · LOAD · COPY · SWAP · CLEAR |

The chosen option is dispatched through the table at 0xAFAD with a `jp (hl)`,
and 0xAFB3 and 0xAFB7 are offsets **inside that same table**: the three screens
share the dispatcher.

## Where a user course lives

The eighteen holes are in RAM, from 0xD04B and 480 bytes apart; the pointers are
in the table at 0xBEF0. And three things are kept separately per hole:

- the **par** (0xCF38 + hole),
- whether it has a **green and a tee** (0xCF26 + hole),
- and the **three digits of the distance** (0xCF48 + 3 × hole).

## Painting

You paint tile by tile, with whichever was picked in SETCHR out of the **136**
the list at 0xBCD1 offers. The space bar drops one, Z drops two.

Two kinds of tile cannot be painted over: 0xD7 to 0xF7 are green and tee, and
0xB01B checks before writing. To place those there are the eight **stamps** at
0xBD93: three tees — one per par, three by two tiles — and five greens, four by
two and with the flag inside. 0xB9B4 checks the stamp fits before dropping it,
and dropping a tee notes the hole's par while dropping a green marks it complete.

## Measuring the distance

`DIST.` is the editor's most curious corner. It does not measure in a straight
line: it makes you **mark up to three points** — as many as the par minus two —
and sums tee to point, point to point and point to flag (0xB1A7). The total is
doubled, clamped to 999 and written in three digits.

And there is a nice detail: before clamping, 0xB1D3 reads the Z80's **R refresh
register** and uses its bit 0 to add one or not. It is a free die, and it keeps
the figure from always coming out even.

If the hole has no green or no tee, the editor will not measure: it writes
"GREEN OR TEE NOT FOUND." and sits there.

## Trying the hole

`SHOT` plays a real shot over the hole being edited, with the same routine the
game uses. During the shot there are three keys of its own: `0x0B` puts the aim
on the flag, `0x2F` returns it to where it was, and the joystick changes the wind
— left and right the strength, up and down the direction.

## SWAP brings in the cartridge's holes

`SWAP` does not swap two holes around: it **brings in a hole from the two courses
in the ROM**. The joystick pages through all thirty-six, and 0xB3F2 points
(0xC000) at 0x716B, steps out of editor mode for a moment so it can interpret the
script from ROM, builds the hole and copies it into the buffer with its par and
its distance.

So a user course can start life as QUEEN SIDE with two holes changed.

## And what it saves is the 1984 file

This is the best part. 0xBF14 compresses the eighteen holes into the script
format — 0xBFAE does the run-length compression against the three materials at
0xBFF2 — and puts these twenty-one bytes in front:

    push af / push hl
    ld hl,0c066h / ld (0e000h),hl
    ld hl,0c08ah / ld (0e002h),hl
    ld a,001h    / ld (0e004h),a
    pop hl / pop af / ret

That fragment is not this cartridge's. It is **exactly** the one in front of the
SDATA, WDATA and NDATA files on the 1985 tape, and what it does is point 0xE000
and 0xE002 — the two tables of the 1984 *Hole in One* — at the freshly loaded
course.

And the offsets line up. In the tape file the fragment sits at 0xC050 and the two
tables at 0xC066 and 0xC08A, that is, 0x16 and 0x3A bytes from the start. Here
the fragment is copied to 0xCF81, the eighteen-hole table is filled at 0xCF97 and
the second at 0xCFBB: 0x16 and 0x3A. The same file, byte for byte.

**A course built with this 1986 cartridge's editor loads into the 1984 *Hole in
One*** with `BLOAD"CAS:",R` and `CALL GOLF`.

## The tape, and the page trick

Saving and loading is what makes 0xBE32 call 0x72D4, an address that in this
cartridge lands in the middle of the course scripts. The trick is one instruction
earlier: 0xBE16 does an ENASLT with EXPTBL[0] and **page 1 becomes the BASIC
ROM**, whose cassette routines are at 0x6FD7, 0x700B, 0x72D4 and 0x72E9.

Page 2, where the whole editor lives, is not touched. That is why the code can
keep running while its own first half is out of the map. When it is done, 0xBE1B
brings it back with the slot `init` stored at 0xFEDB right at boot.
