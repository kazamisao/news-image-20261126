"""news-image-20261126: deliver the day's front page as entry.png.

The picture itself is committed beside this file. It is a one-page
newspaper, "Edisi Dunia", summing up Thursday 26 November 2026: the
FCC clearing SpaceX to deploy a million satellites, the Musk pledge of
two SpaceX shares for every American child, the drone strike that
killed two Italians in Kuwait, Cairo's tanker fire, and the Bank of
Korea's rate hike next to Nvidia's CreditWatch warning.

The judging sandbox gives this program no network and a read-only
checkout, and asks for the picture at the output directory. So the
whole job here is a faithful copy: read the committed PNG bytes and
write them out again, untouched, under the name entry.png.
"""

from pathlib import Path
import os
import sys

SOURCE = Path(__file__).resolve().parent / "entry.png"
TARGET_NAME = "entry.png"


def output_dir() -> Path:
    """Where the grader wants the picture: $MAKEFUN_OUTPUT_DIR, else /output."""
    raw = os.environ.get("MAKEFUN_OUTPUT_DIR")
    return Path(raw) if raw else Path("/output")


def deliver() -> Path:
    """Copy the committed picture into the output folder; return its path."""
    folder = output_dir()
    folder.mkdir(parents=True, exist_ok=True)
    target = folder / TARGET_NAME
    target.write_bytes(SOURCE.read_bytes())
    return target


def main() -> int:
    deliver()
    return 0


if __name__ == "__main__":
    sys.exit(main())
