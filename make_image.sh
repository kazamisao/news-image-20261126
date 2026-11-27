#!/bin/sh
# make_image.sh -- compose entry.png, the Edisi Dunia front page for
# Thursday 26 November 2026 (make.fun competition news-image-20261126).
#
# This machine has no PIL, so the page is typeset with ffmpeg alone:
# a paper-coloured canvas, drawbox rules, and drawtext for every line.
# Each line of type is first saved to its own small file, which keeps
# quoting and escaping out of the picture entirely. Lines containing a
# percent sign are drawn with expansion switched off, or ffmpeg would
# eat the character. Usage: sh make_image.sh  (writes ./entry.png)

set -eu
cd "$(dirname "$0")"

SERIF=/usr/share/fonts/truetype/dejavu/DejaVuSerif-Bold.ttf
BOLD=/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf
REG=/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf
INK=0x191919
RED=0x8a1f1f
PAPER=0xf8f3e6

D=$(mktemp -d)
trap 'rm -rf "$D"' EXIT

# put <name> <text>: save one line of type for later drawing.
put() { printf '%s' "$2" > "$D/$1.txt"; }

put masthead 'EDISI DUNIA'
put dateline 'THURSDAY, 26 NOVEMBER 2026'
put tagline 'THE WORLD IN ONE PAGE'

put lead_kick 'SPACE - THE LEAD STORY'
put lead_h1 'FCC CLEARS SPACEX FOR'
put lead_h2 '1 MILLION SATELLITES'
put lead_sub 'Starmind orbital data centres win a first-of-its-kind approval'
put lead_1 'The US Federal Communications Commission green-lit SpaceX to'
put lead_2 'deploy up to one million satellites for its Starmind orbital'
put lead_3 'data-centre network - a new scale for space infrastructure.'

put pledge_kick 'BUSINESS - THE PLEDGE'
put pledge_h1 'TWO SPACEX SHARES'
put pledge_h2 'FOR EVERY US CHILD'
put pledge_1 'Elon Musk pledged two SpaceX shares'
put pledge_2 'for every American child - one from'
put pledge_3 'the company, one from him - a plan'
put pledge_4 'valued at more than $18 billion, on'
put pledge_5 'top of the Trump Accounts gifts.'

put kuwait_kick 'MIDDLE EAST - CONFLICT'
put kuwait_h1 'DRONE STRIKE KILLS TWO'
put kuwait_h2 'ITALIANS IN KUWAIT'
put kuwait_1 'Two Italian citizens were killed by'
put kuwait_2 'drone strike debris in Kuwait, Rome'
put kuwait_3 'and the BBC reported, as fallout from'
put kuwait_4 'the Iran conflict spread further'
put kuwait_5 'across the Gulf states.'

put cairo_kick 'EGYPT - DISASTER'
put cairo_h1 'CAIRO TANKER FIRE TOLL'
put cairo_h2 'RISES TO 31 DEAD'
put cairo_1 'Egypt detained the driver of a fuel'
put cairo_2 'tanker whose crash and fire killed'
put cairo_3 '31 people, as the health minister'
put cairo_4 'visited the injured in hospital.'

put mkt_kick 'MARKETS - ECONOMY'
put mkt_h1 'KOREA HIKES; NVIDIA ON'
put mkt_h2 'CREDITWATCH NEGATIVE'
put mkt_1 'The Bank of Korea raised rates 25bp'
put mkt_2 'to 3.25% on a chip-driven boom. S&P'
put mkt_3 'put Nvidia on CreditWatch Negative.'
put mkt_4 'Thanksgiving-thin US trade: Dow up'
put mkt_5 '0.33%, the Nasdaq down 0.62%.'

put also 'ALSO - HOUTHIS HIT SAUDI JAZAN REFINERY; 13 DIE IN INDONESIA MINE FLOOD'
put footer 'All stories as reported on 26 November 2026'

# The filter chain is assembled piece by piece in CHAIN.
CHAIN=''
# line <font> <size> <colour> <x> <y> <name>: one ordinary line of type.
line() {
  CHAIN="${CHAIN}drawtext=fontfile=$1:fontsize=$2:fontcolor=$3:x=$4:y=$5:textfile=$D/$6.txt,"
}
# raw <...>: same, but the text is taken literally (percent signs survive).
raw() {
  CHAIN="${CHAIN}drawtext=fontfile=$1:fontsize=$2:fontcolor=$3:x=$4:y=$5:textfile=$D/$6.txt:expansion=none,"
}
# rule <x> <y> <w> <h>: one filled ink rectangle.
rule() {
  CHAIN="${CHAIN}drawbox=x=$1:y=$2:w=$3:h=$4:color=$INK:t=fill,"
}

# Masthead
line "$SERIF" 72 "$INK" '(w-text_w)/2' 22 masthead
rule 40 116 944 5
rule 40 127 944 2
line "$BOLD" 27 "$INK" '(w-text_w)/2' 140 dateline
line "$REG" 17 "$INK" '(w-text_w)/2' 176 tagline
rule 40 204 944 2

# The lead story, full width
line "$BOLD" 17 "$RED" 40 220 lead_kick
line "$BOLD" 37 "$INK" 40 246 lead_h1
line "$BOLD" 37 "$INK" 40 292 lead_h2
line "$REG" 22 "$INK" 40 342 lead_sub
line "$REG" 19 "$INK" 40 384 lead_1
line "$REG" 19 "$INK" 40 414 lead_2
line "$REG" 19 "$INK" 40 444 lead_3
rule 40 484 944 2

# First row of two columns, divider between them
rule 510 506 2 218
line "$BOLD" 15 "$RED" 40 504 pledge_kick
line "$BOLD" 25 "$INK" 40 528 pledge_h1
line "$BOLD" 25 "$INK" 40 560 pledge_h2
line "$REG" 17 "$INK" 40 600 pledge_1
line "$REG" 17 "$INK" 40 627 pledge_2
line "$REG" 17 "$INK" 40 654 pledge_3
line "$REG" 17 "$INK" 40 681 pledge_4
line "$REG" 17 "$INK" 40 708 pledge_5

line "$BOLD" 15 "$RED" 534 504 kuwait_kick
line "$BOLD" 25 "$INK" 534 528 kuwait_h1
line "$BOLD" 25 "$INK" 534 560 kuwait_h2
line "$REG" 17 "$INK" 534 600 kuwait_1
line "$REG" 17 "$INK" 534 627 kuwait_2
line "$REG" 17 "$INK" 534 654 kuwait_3
line "$REG" 17 "$INK" 534 681 kuwait_4
line "$REG" 17 "$INK" 534 708 kuwait_5
rule 40 738 944 2

# Second row of two columns
rule 510 758 2 200
line "$BOLD" 15 "$RED" 40 756 cairo_kick
line "$BOLD" 25 "$INK" 40 780 cairo_h1
line "$BOLD" 25 "$INK" 40 812 cairo_h2
line "$REG" 17 "$INK" 40 848 cairo_1
line "$REG" 17 "$INK" 40 874 cairo_2
line "$REG" 17 "$INK" 40 900 cairo_3
line "$REG" 17 "$INK" 40 926 cairo_4

line "$BOLD" 15 "$RED" 534 756 mkt_kick
line "$BOLD" 25 "$INK" 534 780 mkt_h1
line "$BOLD" 25 "$INK" 534 812 mkt_h2
line "$REG" 17 "$INK" 534 848 mkt_1
raw  "$REG" 17 "$INK" 534 874 mkt_2
line "$REG" 17 "$INK" 534 900 mkt_3
line "$REG" 17 "$INK" 534 926 mkt_4
raw  "$REG" 17 "$INK" 534 952 mkt_5

# The also band and the footer
rule 40 972 944 3
line "$BOLD" 19 "$INK" 40 982 also
line "$REG" 13 "$INK" '(w-text_w)/2' 1009 footer

CHAIN=${CHAIN%,}
ffmpeg -y -v error -f lavfi -i "color=c=${PAPER}:s=1024x1024" \
  -vf "$CHAIN" -frames:v 1 entry.png

ls -la entry.png
