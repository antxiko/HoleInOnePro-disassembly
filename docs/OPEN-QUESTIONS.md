# Open questions

What is not settled, said as what it is.

## The putter's curve window falls off the table

The table at 0x5495 has **thirteen** pairs — the low and high limits of the curve
bar — one per club, and the cartridge has **fifteen** clubs: the last two are the
putter.

On AVERAGE the index is the club times two, so club 13 reads at 0x54AF and club
14 at 0x54B1, that is, **inside the code** that starts right behind the table.
The bytes that come out are (0x3A, 0x34) and (0xCA, 0xFE), and since the bar
never goes above 0x1C, the comparison always lands on the same side.

This is measured and it is what the code does. What is **not** checked is whether
it shows in play: 0x539F does not run the curve bar with the putter, so the value
that comes out of there may never be used. It would need following in the
emulator.

On EXPERT and PROFESSIONAL the index is the club halved, and then it does land
inside the table.

## The first three club tables are thirteen long too

The same happens at 0x6437. There are four tables in a row: braking (0x6437),
climb duration (0x6444) and range (0x6451) have **thirteen** entries, and the
launch-speed one (0x645E) has **fifteen** — that one does include both putters,
0x1E and 0x7F.

0x587A and 0x5880 read the first two for any club, putters included, so with the
putter they read out of the neighbouring table. But 0x58A3 branches away before
using them, and it is not established that what was left in (0xC61C) and (0xC61A)
ever matters.

## The sound has not been listened to

The twelve tracks are followed with the cartridge's own interpreter and their
boundaries fit without a gap, but nobody has compared what plays with what this
reading says should play. The boundaries are measured; the music is not.

## The editor has not been exercised end to end

Its labels, stamps, tile list and file format come out of the code and the
binary. What has not been done is save a course with the editor, load it into the
1984 *Hole in One* and play it. That the file has the same header and the same
offsets is measured byte for byte; that it plays is not.

## The two bytes at 0x40DC

Between the menu's three tables there are two bytes none of them reaches. Read as
a pointer they would give 0x4E41, which is a code address but not one anything
leads to. It may be an entry from an earlier version of the menu, or padding.

## The spare byte in the tone table

The tone table at 0x6C0D has room for 44 notes and the highest the twelve tracks
use is 43. One byte, 0x6C65, is read by nobody. Same for the one at 0x6CD7,
between track 2 and track 4.

## And one that is settled

When this disassembly started it was open why 0xBE32 does a `call 072d4h`, an
address that lands inside the course scripts. Not any more: the instruction
before it swaps page 1 for the BASIC ROM, and 0x72D4 is a cassette routine of
**its**. It is told in [Findings](FINDINGS.html).
