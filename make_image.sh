#!/bin/sh
# make_image.sh - builds entry.png, the "Edisi Dunia" front page that sums up
# the world news of Thursday 26 November 2026 for make.fun news-image-20261126.
#
# No PIL on this machine, so the page is composed with ffmpeg's drawtext and
# drawbox filters only. Every line of text lives in its own textfile so no
# shell or filter escaping can garble it. Run: sh make_image.sh
# Output: entry.png beside this script (1024x1024, well under 1 MiB).

set -eu
cd "$(dirname "$0")"

SANS=/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf
BOLD=/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf
SERIFB=/usr/share/fonts/truetype/dejavu/DejaVuSerif-Bold.ttf
INK=0x191919
ACCENT=0x8a1f1f
PAPER=0xf8f3e6

TXT=$(mktemp -d)
trap 'rm -rf "$TXT"' EXIT
T() { printf '%s' "$2" > "$TXT/$1.txt"; }

# --- Masthead ---------------------------------------------------------------
T masthead "EDISI DUNIA"
T dateline "THURSDAY, 26 NOVEMBER 2026"
T tagline  "THE WORLD IN ONE PAGE"

# --- Lead story: FCC clears SpaceX for a million satellites ------------------
T lead_kicker "SPACE - THE LEAD STORY"
T lead_head   "FCC CLEARS SPACEX FOR"
T lead_head2  "1 MILLION SATELLITES"
T lead_sub    "Starmind orbital data centres win a first-of-its-kind approval"
T lead_b1 "The US Federal Communications Commission green-lit SpaceX to"
T lead_b2 "deploy up to one million satellites for its Starmind orbital"
T lead_b3 "data-centre network - a new scale for space infrastructure."

# --- Row 1, left: Musk pledges SpaceX shares to every US child ---------------
T mu_kicker "BUSINESS - THE PLEDGE"
T mu_h1 "TWO SPACEX SHARES"
T mu_h2 "FOR EVERY US CHILD"
T mu_b1 "Elon Musk pledged two SpaceX shares"
T mu_b2 "for every American child - one from"
T mu_b3 "the company, one from him - a plan"
T mu_b4 "valued at more than \$18 billion, on"
T mu_b5 "top of the Trump Accounts gifts."

# --- Row 1, right: Iranian drone strike kills two Italians in Kuwait ---------
T kw_kicker "MIDDLE EAST - CONFLICT"
T kw_h1 "DRONE STRIKE KILLS TWO"
T kw_h2 "ITALIANS IN KUWAIT"
T kw_b1 "Two Italian citizens were killed by"
T kw_b2 "drone strike debris in Kuwait, Rome"
T kw_b3 "and the BBC reported, as fallout from"
T kw_b4 "the Iran conflict spread further"
T kw_b5 "across the Gulf states."

# drawtext helper: DT <font> <size> <color> <x> <y> <name>
F=""
DT() {
  F="${F}drawtext=fontfile=$1:fontsize=$2:fontcolor=$3:x=$4:y=$5:textfile=$TXT/$6.txt,"
}
# DTN: same, but with text expansion disabled so a literal % survives
DTN() {
  F="${F}drawtext=fontfile=$1:fontsize=$2:fontcolor=$3:x=$4:y=$5:textfile=$TXT/$6.txt:expansion=none,"
}
# drawbox helper: DB <x> <y> <w> <h>
DB() {
  F="${F}drawbox=x=$1:y=$2:w=$3:h=$4:color=$INK:t=fill,"
}

# Masthead block
DT "$SERIFB" 72 "$INK" "(w-text_w)/2" 22 masthead
DB 40 116 944 5
DB 40 127 944 2
DT "$BOLD" 27 "$INK" "(w-text_w)/2" 140 dateline
DT "$SANS" 17 "$INK" "(w-text_w)/2" 176 tagline
DB 40 204 944 2

# Lead block
DT "$BOLD" 17 "$ACCENT" 40 220 lead_kicker
DT "$BOLD" 37 "$INK" 40 246 lead_head
DT "$BOLD" 37 "$INK" 40 292 lead_head2
DT "$SANS" 22 "$INK" 40 342 lead_sub
DT "$SANS" 19 "$INK" 40 384 lead_b1
DT "$SANS" 19 "$INK" 40 414 lead_b2
DT "$SANS" 19 "$INK" 40 444 lead_b3
DB 40 484 944 2

# Row 1: two columns with a vertical divider
DB 510 506 2 218
DT "$BOLD" 15 "$ACCENT" 40 504 mu_kicker
DT "$BOLD" 25 "$INK" 40 528 mu_h1
DT "$BOLD" 25 "$INK" 40 560 mu_h2
DT "$SANS" 17 "$INK" 40 600 mu_b1
DT "$SANS" 17 "$INK" 40 627 mu_b2
DT "$SANS" 17 "$INK" 40 654 mu_b3
DT "$SANS" 17 "$INK" 40 681 mu_b4
DT "$SANS" 17 "$INK" 40 708 mu_b5

DT "$BOLD" 15 "$ACCENT" 534 504 kw_kicker
DT "$BOLD" 25 "$INK" 534 528 kw_h1
DT "$BOLD" 25 "$INK" 534 560 kw_h2
DT "$SANS" 17 "$INK" 534 600 kw_b1
DT "$SANS" 17 "$INK" 534 627 kw_b2
DT "$SANS" 17 "$INK" 534 654 kw_b3
DT "$SANS" 17 "$INK" 534 681 kw_b4
DT "$SANS" 17 "$INK" 534 708 kw_b5
DB 40 738 944 2

# --- Row 2, left: Cairo tanker fire ------------------------------------------
T eg_kicker "EGYPT - DISASTER"
T eg_h1 "CAIRO TANKER FIRE TOLL"
T eg_h2 "RISES TO 31 DEAD"
T eg_b1 "Egypt detained the driver of a fuel"
T eg_b2 "tanker whose crash and fire killed"
T eg_b3 "31 people, as the health minister"
T eg_b4 "visited the injured in hospital."

# --- Row 2, right: Bank of Korea hike, Nvidia CreditWatch ---------------------
T mk_kicker "MARKETS - ECONOMY"
T mk_h1 "KOREA HIKES; NVIDIA ON"
T mk_h2 "CREDITWATCH NEGATIVE"
T mk_b1 "The Bank of Korea raised rates 25bp"
T mk_b2 "to 3.25% on a chip-driven boom. S&P"
T mk_b3 "put Nvidia on CreditWatch Negative."
T mk_b4 "Thanksgiving-thin US trade: Dow up"
T mk_b5 "0.33%, the Nasdaq down 0.62%."

# --- Also band -----------------------------------------------------------------
T also "ALSO - HOUTHIS HIT SAUDI JAZAN REFINERY; 13 DIE IN INDONESIA MINE FLOOD"
T footer "All stories as reported on 26 November 2026"

# Row 2: two columns with a vertical divider
DB 510 758 2 150
DT "$BOLD" 15 "$ACCENT" 40 756 eg_kicker
DT "$BOLD" 25 "$INK" 40 780 eg_h1
DT "$BOLD" 25 "$INK" 40 812 eg_h2
DT "$SANS" 17 "$INK" 40 852 eg_b1
DT "$SANS" 17 "$INK" 40 879 eg_b2
DT "$SANS" 17 "$INK" 40 906 eg_b3
DT "$SANS" 17 "$INK" 40 933 eg_b4

DT "$BOLD" 15 "$ACCENT" 534 756 mk_kicker
DT "$BOLD" 25 "$INK" 534 780 mk_h1
DT "$BOLD" 25 "$INK" 534 812 mk_h2
DT "$SANS" 17 "$INK" 534 852 mk_b1
DT "$SANS" 17 "$INK" 534 879 mk_b2
DT "$SANS" 17 "$INK" 534 906 mk_b3
DT "$SANS" 17 "$INK" 534 933 mk_b4
DTN "$SANS" 17 "$INK" 534 960 mk_b5

# Also band and footer
DB 40 968 944 3
DT "$BOLD" 19 "$INK" 40 978 also
DT "$SANS" 13 "$INK" "(w-text_w)/2" 1006 footer

# Render: one still image from a solid paper-coloured canvas.
F=${F%,}
ffmpeg -y -v error -f lavfi -i "color=c=${PAPER}:s=1024x1024" \
  -vf "$F" -frames:v 1 entry.png

ls -la entry.png
