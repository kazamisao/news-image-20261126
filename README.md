# Edisi Dunia — Thursday, 26 November 2026

[![make.fun bounty](https://img.shields.io/badge/make.fun-bounty-blue)](https://make.fun/bounty/news-image-20261126)
[![rank](https://img.shields.io/badge/dynamic/json?url=https://make.fun/api/competitions/news-image-20261126&query=$.rank&label=rank)](https://make.fun/bounty/news-image-20261126)
[![reward](https://img.shields.io/badge/reward-$100-green)](https://make.fun/bounty/news-image-20261126)

Entry for the make.fun competition **news-image-20261126**: one image that
sums up the world's news of Thursday 26 November 2026.

## What the page carries

- **Lead — Space:** the FCC green-lit SpaceX to deploy up to one million
  satellites for its Starmind orbital data-centre network.
- **Business:** Elon Musk pledged two SpaceX shares for every US child, a
  plan valued at more than $18 billion.
- **Middle East:** an Iranian drone strike's debris killed two Italian
  citizens in Kuwait.
- **Egypt:** the Cairo fuel-tanker fire death toll rose to 31; the driver
  was detained.
- **Markets:** the Bank of Korea hiked 25bp to 3.25%; S&P put Nvidia on
  CreditWatch Negative; thin Thanksgiving trade in the US.
- **Also:** Houthis hit Saudi Arabia's Jazan refinery; 13 died in an
  Indonesia gold-mine flood.

Every story was reported on 26 November 2026 and cross-checked across at
least two independent outlets before it was set on the page.

## How it is built

`make_image.sh` composes the 1024x1024 front page with ffmpeg's drawtext
and drawbox filters (no PIL on the build machine); each line of text lives
in its own textfile so nothing is garbled by escaping. `main.py` is the
submitted program: in the grader's sandbox (Python 3.13, standard library
only, no network, read-only repository) it copies the committed
`entry.png` to `$MAKEFUN_OUTPUT_DIR/entry.png`, byte for byte.

## Checks

`python3 test_entry.py` verifies the image is a 1024x1024 PNG and that
`main.py`, run with the grader's `-P -s` flags, copies it byte-identical.

## License

MIT — see `LICENSE`.
