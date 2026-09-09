# Findings

What turned up when we took it apart, with the address of everything so it can
be checked.

## Who made it, said by the cartridge itself

The credits screen is not a capture: it is four rows of twenty-one characters
that 0x51BF lays into the name table, expanded from the compressed text at
0x51E5.

    © HAL LABORATORY 1985
    PRODUCER   F.NAKAMURA
    PROGRAMMER S.IWATA

The at sign is the copyright symbol in the cartridge's font, and `>` is its full
stop: you can see both in the pattern table itself. The cartridge is from 1986
and its credits say 1985.

## The opponent does not compute its shot: it rehearses it

This is the big one. When it is the computer's turn, 0x5B39 rolls it some
starting values — power between 0x18 and 0x1B, curve between 0x19 and 0x20, the
angle to the flag and a club obtained by dividing the distance by eight — and
then it enters the loop at 0x5BB4, which **plays the whole shot with the real
physics**.

When it ends it looks at where the ball landed and reacts:

| what happened | what it changes |
|---|---|
| into the water (0x5CB4) | a die decides whether to raise or lower the club, the power, the angle or the curve |
| short (0x5DFA) | fans the angle, or takes a club more and a point of power less |
| too long (0x5E76) | trims the power proportionally |
| out of bounds or bunker (0x5DB4) | drops a club |
| **holed out** (0x5D95) | knocks a point off, so it does not hole every one |

And hits it again. Until it likes the result, or until it runs out of the tries
it has (0xC119, which grows when it is losing: from 4 to 6 when three or more
down).

Only then does 0x5408 replay it in front of the player, walking the power and
curve bars to the values already decided. **What you see is not the shot: it is
the re-enactment of the rehearsal.** During the rehearsal, (0xC118) set to one
switches off the joystick, the frame wait and the drawing, so the dozens of shots
the opponent plays fit between two frames.

On the green it does the same with the putt (0x6091), where the starting power
is half the distance plus three.

## The terrain is decided by the pixel

0x629C classifies what is under the ball by tile number: 0x60 to 0x77 trees,
0x94 to 0xB3 bunker, 0xB4 to 0xD1 water. But tiles that straddle two terrains
cannot be resolved that way, and for those the cartridge **reads the VRAM**.

- **0x63B1** pulls the exact bit under the ball out of the pattern table, with
  the right one of the eight masks at 0x63E9.
- **0x63D3** reads that pixel's nibble out of the **colour** table: the high one
  if the bit is set, the low one if not.

That is what separates fairway from rough, bunker from water, and a bank from
everything else. Collision against the scenery is settled by the drawing, and
not by a second table someone would have to keep in step with it.

## Golf's honour rule is in the code

In golf, between two players, the one farther from the hole plays first. 0x46FA
does exactly that: it measures both distances with 0x475C — the difference in X
and in Y, each in absolute value and halved so they fit, then the root of the sum
of squares — and gives the turn to whoever is worse off. If both have reached the
green, it also switches to the close-up view.

## The thirty-five professionals

At 0x5009, one after another with no pointer and no length: **bit 7 of the last
character** marks where each name ends.

    C.STRANGE  L.WADKINS  C.PEETE     R.FLOYD    C.PAVIN
    M.OMEARA   C.STADLER  B.LANGER    T.WATSON   F.ZOELLER
    R.MALTBIE  H.IRWIN    T.KITE      P.STEWART  L.MIZE
    H.SUTTON   J.SINDELAR J.MAHAFFEY  S.BALLESTEROS  P.JACOBSEN
    L.RINKER   B.EASTWOOD D.POOLEY    G.BURNS    S.SIMPSON
    I.AOKI     L.NELSON   J.NICKLAUS  G.NORMAN   L.TREVINO
    T.NAKAJIMA M.KURAMOTO B.LIETZKE   T.OZAKI    N.OZAKI

And the tournament does not simulate them shot by shot. For each hole, 0x4EC9
rolls a die, subtracts the personal difficulty each was dealt at the start of the
round (0xC09B), adds their **fixed adjustment** from the table at 0x5130 — one
byte from 0 to 7 per golfer — and looks up which band it falls in. The bands give
+2, +1, par, −1 and −2, and there are **three tables** of bands: which one is
used depends on whether the player is under, on, or over par. Against a player
who is going well, the field tightens.

With a single player in TOURNAMENT, 0x4F4A also lets you **choose which
professional you play against**, paging the list with the arrows.

## The flag is not in the script

The script carries the green, but not where the flag is planted. That is rolled
every round: 0x7005 throws a die modulo nine and the table at 0x70F2 gives the
coordinates, on a three-by-three grid that differs per par — tighter on the par
3s than on the 4s and 5s.

Same for the wind and the green's slope: all three are rolled when the hole is
built, and the level decides how much.

## The hole's header is its palette

A hole takes 311 bytes on average, and the trick is in the first three. The
cartridge copies them to 0xCEC0 and there they stay. Then, in the script, a
`0x3n`, `0x4n` or `0x5n` byte repeats the first, second or third of them *n*+1
times.

What links the two is a subtraction of three: the index comes from the opcode's
**high nibble** and the table it reads from starts at **0xCEBD**, three bytes
before the header, exactly so that 3, 4 and 5 land on it. There is no palette
table: there is an offset that makes the hole's header *be* the palette.

It is the same format, byte for byte, as the 1984 *Hole in One*.

## The `call 0x72D4` that does not point in here

At 0xBE32 there is a `call 072d4h`, and 0x72D4 lands in the middle of the course
scripts. It is not a tracing error: that address **is no longer the cartridge**
when it executes.

    L_BE16   ld a,(0fcc1h)   ; EXPTBL[0], the main ROM's slot
             ld hl,04000h
             jp 00024h       ; ENASLT: page 1 becomes the BASIC ROM

0x6FD7, 0x700B, 0x72D4 and 0x72E9 are cassette routines in the BASIC ROM. Page 2,
where all that code lives, is not touched, which is why it can keep running while
its own first half is out of the map. When it is done, 0xBE1B brings it back with
the slot `init` stored at 0xFEDB.

## Nineteen bytes nobody calls

0xB885 is a complete routine — it builds 10×H+L from (0xCEF9) and returns carry
if the result is zero or over 18, that is, it validates a hole number — and **its
two bytes appear nowhere in the ROM**. The routine before it ends in a `ret`, so
nothing falls into it either. It is dead code from the editor.
