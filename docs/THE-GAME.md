# The game

*Hole in One Professional* is HAL's second pass at their 1984 golf game. Where
that one had a course, this has two; where that one loaded courses from tape,
this one carries **an editor inside**; and where that one let you play alone or
against a friend, this one sits you across from thirty-five real professionals.

## The menu

Four lines, and all four come out of the binary:

| line | variable | values |
|---|---|---|
| PLAYER | 0xC003 | 1 or 2 |
| LEVEL | 0xC007 | AVERAGE · EXPERT · PROFESSIONAL |
| GAME | 0xC005 | STROKE PLAY · MATCH PLAY · TOURNAMENT · CONSTRUCTION |
| COURSE | 0xC004 | QUEEN SIDE · KING SIDE · USER |

`USER` only appears if a user course is loaded: 0x40EF and 0x40FD check
(0xCED3) and, if it is zero, treat the line as if it had two values instead of
three.

And the level is not cosmetic. It decides the speed of the power and curve bars
(0x560A: one on AVERAGE, two on PROFESSIONAL), the width of the accuracy window
(0x53B1 uses one window per club on AVERAGE and one per two clubs from EXPERT
up), the scatter when playing out of rough (0x584C: 0x26 against 0x40) and the
strength of the wind (0x7073 clears bit 6 on AVERAGE).

## The two courses

| course | par | length | par 3s | par 4s | par 5s |
|---|---|---|---|---|---|
| QUEEN SIDE | 72 | 6,166 m | 4 | 10 | 4 |
| KING SIDE | 72 | 6,290 m | 4 | 10 | 4 |

Same par and same spread, and yet thirty-six different holes. KING SIDE is
longer and, looking at them, a good deal harder: more water, narrower fairways
and much more black — which is tile 0x00, and the game treats it as out of
bounds.

The thirty-six scripts take 11,193 bytes in total, 311 on average per hole.

## The shot

Three steps, and all three are the same machine with different limits:

1. **the aim**, which the joystick turns a degree at a time (0x54AF);
2. **the power**, a bar that runs up and down between 0 and 0x1C and that the
   trigger stops (0x55E6);
3. **the curve**, another bar between 0 and 0x38 (0x5676).

The power that comes off the bar is not the one used: the real one is
`(0xC641) × 8 + 0x1F`, so there is a minimum you cannot take off. And what
decides whether the ball flies straight is the window at 0x5495: two bytes per
club, a low limit and a high one. If the curve bar stops below the first, the
difference is stored as **hook**; above the second, as **slice**. Then, during
the flight, 0x58F0 bends the angle a degree every so many frames.

There is no curve bar with the putter: 0x539F only plays it if the club is
below 13.

## The fifteen clubs

    1W 2W 3W 4W | 3I 4I 5I 6I | 7I 8I 9I | PW SW PT PT

Three bytes per club at 0x4B16: the first groups the swing — 0x00 the woods,
0x04 and 0x08 the irons, 0x0C the wedges and putter — and the other two are the
label's two letters. The last entry repeats PT, and it is not an oversight: on
the fairway you can select club 13, and on the green the game forces 14
(0x5589).

And that same table, byte for byte, is inside the CONST file on the 1985 *Hole
In One Extension Course* tape.

## The modes

- **STROKE PLAY**: count strokes and that is that.
- **MATCH PLAY**: count holes won. 0x43BD tracks the lead (0xC074) and who has
  it (0xC073), and when the lead exceeds the holes remaining the match ends with
  its "3 AND 2" written out by hand at 0x4451.
- **TOURNAMENT**: thirty-six entrants, thirty-five of them real professionals,
  with a live leaderboard.
- **CONSTRUCTION**: the editor. It has [its own page](THE-EDITOR.html).

## The keys

| key | what it does |
|---|---|
| F1 | shows the eighteen-hole scorecard |
| F2 | the tournament leaderboard (the arrows page through it) |
| F10 then F6 | back to the menu |
| STOP | cancels the shot being set up |

F1 and F2 redraw nothing: they change VDP register 2 to show another name table
that was already built.
