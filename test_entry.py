"""Checks for the news-image-20261126 entry.

Run with: python3 -m pytest test_entry.py -q   (or plain python3 test_entry.py)
"""

import os
import struct
import subprocess
import sys
import tempfile

HERE = os.path.dirname(os.path.abspath(__file__))


def png_size(path):
    with open(path, "rb") as fh:
        head = fh.read(24)
    assert head[:8] == b"\x89PNG\r\n\x1a\n", "entry.png is not a PNG"
    width, height = struct.unpack(">II", head[16:24])
    return width, height


def test_image_is_square_1024():
    assert png_size(os.path.join(HERE, "entry.png")) == (1024, 1024)


def test_main_copies_image_byte_identical():
    with tempfile.TemporaryDirectory() as tmp:
        env = dict(os.environ, MAKEFUN_OUTPUT_DIR=tmp)
        run = subprocess.run([sys.executable, "-P", "-s",
                              os.path.join(HERE, "main.py")],
                             env=env, capture_output=True, text=True)
        assert run.returncode == 0, run.stderr
        with open(os.path.join(HERE, "entry.png"), "rb") as fh:
            original = fh.read()
        with open(os.path.join(tmp, "entry.png"), "rb") as fh:
            copied = fh.read()
        assert copied == original


if __name__ == "__main__":
    test_image_is_square_1024()
    test_main_copies_image_byte_identical()
    print("all tests passed")
