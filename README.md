# Edisi Dunia — the world of Thursday 26 November 2026, on one page

[![make.fun · news-image-20261126](https://make.fun/badge/news-image-20261126.svg)](https://make.fun/bounty/news-image-20261126?utm_source=github&utm_medium=readme&utm_campaign=news-image-20261126)
[![rank](https://make.fun/badge/news-image-20261126/kazamisao/news-image-20261126/rank.svg)](https://make.fun/bounty/news-image-20261126/leaderboard?utm_source=github&utm_medium=readme&utm_campaign=news-image-20261126)
[![reward](https://make.fun/badge/news-image-20261126/kazamisao/news-image-20261126/reward.svg)](https://make.fun/bounty/news-image-20261126?utm_source=github&utm_medium=readme&utm_campaign=news-image-20261126)

This repository is an entry to the make.fun competition
[news-image-20261126](https://make.fun/bounty/news-image-20261126): a
single image that sums up the world's news of Thursday 26 November
2026.

## What is on the page

- **Lead, space:** the US Federal Communications Commission cleared
  SpaceX to deploy up to one million satellites for its Starmind
  orbital data-centre network — the first approval of its kind.
- **Business:** Elon Musk pledged two SpaceX shares for every American
  child, one from the company and one from himself, a plan valued at
  more than $18 billion.
- **Middle East:** debris from an Iranian drone strike killed two
  Italian citizens in Kuwait.
- **Egypt:** the death toll from the Cairo fuel-tanker fire rose to
  31, and the driver was detained.
- **Markets:** the Bank of Korea raised its rate by 25bp to 3.25% on a
  chip-driven boom; S&P placed Nvidia on CreditWatch Negative; US
  trading was thin for Thanksgiving (Dow +0.33%, Nasdaq −0.62%).
- **Also:** Houthis struck Saudi Arabia's Jazan refinery, and thirteen
  people died in an Indonesian gold-mine flood.

Each story was reported on 26 November 2026 and was cross-checked
against at least two independent outlets before it was set in type.

## How it works

`main.py` is the submitted program. The sandbox that runs it has no
network and a read-only checkout, so the program simply copies the
committed `entry.png` into `$MAKEFUN_OUTPUT_DIR` (falling back to
`/output`), byte for byte.

The page itself is typeset by `make_image.sh`: ffmpeg draws a
1024×1024 paper-coloured canvas with drawbox rules and drawtext lines,
each line kept in its own text file so no escaping can corrupt it.
Lines carrying a percent sign are drawn with text expansion off.

## Checking it

    python3 test_entry.py

confirms the picture is a 1024×1024 PNG and that the program, run with
the grader's `-P -s` flags, delivers it unchanged, twice in a row.

## License

MIT — see `LICENSE`.
