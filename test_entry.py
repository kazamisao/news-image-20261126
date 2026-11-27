"""Tests for the news-image-20261126 entry.

Plain-python runner: python3 test_entry.py
"""

import os
import struct
import subprocess
import sys
import tempfile

ROOT = os.path.dirname(os.path.abspath(__file__))
PNG = os.path.join(ROOT, "entry.png")
PROGRAM = os.path.join(ROOT, "main.py")


def dimensions(path):
    with open(path, "rb") as handle:
        header = handle.read(24)
    if header[:8] != b"\x89PNG\r\n\x1a\n":
        raise AssertionError("entry.png does not start with the PNG signature")
    return struct.unpack(">II", header[16:24])


def run_program(out_dir):
    env = dict(os.environ)
    env["MAKEFUN_OUTPUT_DIR"] = out_dir
    done = subprocess.run(
        [sys.executable, "-P", "-s", PROGRAM],
        env=env, capture_output=True, text=True, timeout=60,
    )
    if done.returncode != 0:
        raise AssertionError(f"program failed: {done.stderr}")


def check_canvas():
    if dimensions(PNG) != (1024, 1024):
        raise AssertionError("the front page must be 1024 by 1024")


def check_copy_is_exact_and_repeatable():
    with open(PNG, "rb") as handle:
        wanted = handle.read()
    for _ in range(2):
        with tempfile.TemporaryDirectory() as tmp:
            run_program(tmp)
            with open(os.path.join(tmp, "entry.png"), "rb") as handle:
                if handle.read() != wanted:
                    raise AssertionError("the delivered picture differs")


if __name__ == "__main__":
    check_canvas()
    check_copy_is_exact_and_repeatable()
    print("all tests passed")
