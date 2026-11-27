"""Entry program for the make.fun bounty news-image-20261126.

The finished front page lives in this repository as entry.png, rendered by
make_image.sh from the verified headlines of Thursday 26 November 2026. The
grader runs this program in a sandbox with no network and a read-only
repository, so the program's whole job is to copy that committed image into
the output directory, unchanged, which makes every run byte-identical.
"""

import os
import shutil
import sys

HERE = os.path.dirname(os.path.abspath(__file__))


def main() -> int:
    out_dir = os.environ.get("MAKEFUN_OUTPUT_DIR") or "/output"
    os.makedirs(out_dir, exist_ok=True)
    shutil.copyfile(os.path.join(HERE, "entry.png"),
                    os.path.join(out_dir, "entry.png"))
    return 0


if __name__ == "__main__":
    sys.exit(main())
