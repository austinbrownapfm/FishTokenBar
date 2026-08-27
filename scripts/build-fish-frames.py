#!/usr/bin/env python3
"""Generate swimming animation frames for the Fish kingdom sprites.

For each rigged fish SVG in assets/fish-sprites/<species>/*.svg, this:
  1. reads the `#tail` and `#pecfin` groups' data-pivot points,
  2. emits N frames, each rotating the tail (and counter-fluttering the pectoral fin)
     about its pivot to animate a swim stroke,
  3. wraps the 640x400 art in a square 640x640 canvas (vertically centered),
  4. rasterizes each frame SVG to a transparent PNG via `qlmanage` and downsamples to 256px,
  5. writes them to Sources/PokeTokenBar/Resources/fish/<slug>/<stage>/frame-<i>.png

The in-app SpriteStore loads these PNG sequences for fish (bypassing the remote Pokémon
GIF path). Re-run this whenever a sprite SVG changes. Requires macOS `qlmanage` + `sips`.
"""
import os, re, subprocess, sys, tempfile, shutil

REPO = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SRC = os.path.join(REPO, "assets", "fish-sprites")
OUT = os.path.join(REPO, "Sources", "PokeTokenBar", "Resources", "fish")

# Tail-wag stroke (degrees) and a gentle opposite pectoral flutter. 4 frames loop smoothly.
TAIL_ANGLES = [0.0, 7.0, 0.0, -7.0]
PEC_ANGLES  = [0.0, -4.0, 0.0, 4.0]
FRAME_PX = 256

PIVOT_RE = lambda gid: re.compile(r'(<g\s+id="' + gid + r'"[^>]*?data-pivot="(-?\d+(?:\.\d+)?),(-?\d+(?:\.\d+)?)"[^>]*?)>')
SVG_TAG_RE = re.compile(r'<svg\b[^>]*>')


def square_wrap(svg_text):
    """Replace the root <svg> viewBox/size with a vertically-centered 640x640 square."""
    return SVG_TAG_RE.sub(
        '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 -120 640 640" width="640" height="640">',
        svg_text, count=1)


def inject_rotation(svg_text, gid, angle):
    """Add transform="rotate(angle cx cy)" to a group identified by id, using its data-pivot."""
    m = PIVOT_RE(gid).search(svg_text)
    if not m or angle == 0.0:
        return svg_text
    cx, cy = m.group(2), m.group(3)
    injected = m.group(1) + f' transform="rotate({angle} {cx} {cy})">'
    return svg_text[:m.start()] + injected + svg_text[m.end():]


def render_frame(svg_text, out_png, tmpdir):
    tmp_svg = os.path.join(tmpdir, "frame.svg")
    with open(tmp_svg, "w") as f:
        f.write(svg_text)
    # rsvg-convert (librsvg) rasterizes at the target size with a TRANSPARENT background
    # (`--background-color=none`). qlmanage/Quick Look flattens onto opaque white — unusable for a
    # floating desktop pet — so librsvg is required. `brew install librsvg` if missing.
    subprocess.run(["rsvg-convert", "-w", str(FRAME_PX), "-h", str(FRAME_PX),
                    "--background-color=none", tmp_svg, "-o", out_png],
                   stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL, check=False)
    return os.path.exists(out_png)


def main():
    if not os.path.isdir(SRC):
        print(f"no sprites dir at {SRC}", file=sys.stderr); sys.exit(1)
    if os.path.isdir(OUT):
        shutil.rmtree(OUT)
    os.makedirs(OUT, exist_ok=True)
    total = 0
    for species in sorted(os.listdir(SRC)):
        sdir = os.path.join(SRC, species)
        if not os.path.isdir(sdir):
            continue
        for fn in sorted(os.listdir(sdir)):
            if not fn.endswith(".svg"):
                continue
            stage = fn[:-4]  # e.g. "S3", "S4-shiny"
            with open(os.path.join(sdir, fn)) as f:
                base = f.read()
            stage_out = os.path.join(OUT, species, stage)
            os.makedirs(stage_out, exist_ok=True)
            with tempfile.TemporaryDirectory() as tmp:
                for i, (ta, pa) in enumerate(zip(TAIL_ANGLES, PEC_ANGLES)):
                    svg = inject_rotation(base, "tail", ta)
                    svg = inject_rotation(svg, "pecfin", pa)
                    svg = square_wrap(svg)
                    ok = render_frame(svg, os.path.join(stage_out, f"frame-{i}.png"), tmp)
                    if not ok:
                        print(f"FAILED {species}/{stage} frame {i}", file=sys.stderr)
                    else:
                        total += 1
            print(f"  {species}/{stage}: {len(TAIL_ANGLES)} frames")
    print(f"Done: {total} PNG frames under {OUT}")


if __name__ == "__main__":
    main()
