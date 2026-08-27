# Striped Bass · FishDex #004 — Sprite Notes

*Morone saxatilis* · Moronidae · Anadromous · SALTWATER LINE 1.
All sprites: 640×400 viewBox, facing RIGHT, transparent background, hand-authored SVG.
Rig groups per file: `#body`, `#tail` (data-pivot), `#pecfin` (data-pivot).

## Files
| File | Stage | Notes |
|---|---|---|
| `S1.svg` | Juvenile (2–12 in) | slim body, big eye, faint/incomplete forming stripes (dashed, low-opacity) |
| `S2.svg` | Schoolie (12–25 in) | streamlined silver, 7 crisp black horizontal stripes, white belly |
| `S3.svg` | Adult (24–40 in) | deeper robust body, olive-green back, 8 bold unbroken stripes |
| `S4.svg` | Cow / Trophy (45–50+ in) | massive deep belly, dark slate back, 8 heavy bold stripes, trophy glow |
| `S4-shiny.svg` | Cow — Piebald morph | cow geometry + irregular white unpigmented patches; pigmented eye (NOT albino) |

## Palette (hex)
Countershaded flank via vertical linear gradient (dark back → silver → white belly).

| Role | S1 Juv | S2 Schoolie | S3 Adult | S4 Cow / Shiny |
|---|---|---|---|---|
| Back (top of gradient) | `#6b7a72` | `#3f4c44` | `#3a4a3d` (olive) | `#263540` (slate) |
| Upper flank | `#8b9a99` | `#586a63` | `#556a5c` | `#3b4d57` |
| Mid silver | `#c9d1d4` | `#93a1a2` / `#c8d0d4` | `#8d9c96` / `#c6d0d1` | `#788890` / `#bac6cb` |
| Lower flank | `#e8eef0` | `#e6edee` | `#e5ecee` | `#dde6e8` |
| White belly (bottom) | `#f9fbfc` | `#f8fbfc` | `#f8fbfc` | `#f7fafb` |
| Stripes | `#5c6c73` @0.7 (faint) | `#141414` | `#0f0f0f` | `#0a0a0a` |
| Fin membrane | `#aab8bf→#d0dadd` | `#9fb0b8→#c6d2d6` | `#8fa0a6→#c2ced2` | `#6f8088→#aebcc2` |
| Spiny dorsal | `#7c8b8f` | `#6f7f84` | `#61716c` | `#4c5c5a` |
| Outline | `#334149` | `#263038` | `#222c2a` | `#171f24` |
| Eye / catchlight | `#111820` / `#f4f8f9` | same | same | `#0a0f12` / `#f2f7f8` |
| Piebald patch (shiny) | — | — | — | `#f8fbf9`, edge `#dfe8e6` |
| Trophy glow (shiny/S4) | — | — | — | radial `#ffe6a3`→transparent |

## Animation-rig pivot coordinates
| File | `#tail` data-pivot | `#pecfin` data-pivot |
|---|---|---|
| S1 | `138,200` | `480,206` |
| S2 | `132,200` | `478,210` |
| S3 | `130,200` | `482,208` |
| S4 | `123,200` | `486,207` |
| S4-shiny | `123,200` | `486,207` |

Tail group is drawn BEFORE the body group so the body overlaps the caudal seam (no gap when
the tail rotates ±10°). Pectoral drawn AFTER body, pivoting at its base against the flank.

## Species-accuracy checklist (diagnostic marks)
- [x] Streamlined / elongate silvery body (length:depth ≈ 4:1 juvenile → deeper for cow)
- [x] 7–8 CRISP HORIZONTAL BLACK STRIPES running length-wise, gill → tail (S2=7, S3/S4=8)
- [x] Stripes straight & crisp (constant-y lines, clipped to body outline)
- [x] White belly (clear unstriped white zone below lowest stripe)
- [x] TWO SEPARATE dorsal fins — spiny (anterior/right, sawtooth) then soft (posterior/left, rounded), visible gap between
- [x] Forked (bilobed) caudal tail
- [x] Olive-to-slate darker back (olive S3 → dark slate S4), countershaded gradient
- [x] Pectoral + pelvic + anal fins present
- [x] Friendly rounded eye with catchlight
- [x] Juvenile: stripes faint / incomplete / still forming (dashed, low opacity); oversized eye; slimmer
- [x] Cow: massive deep-bellied, dark slate back, heavy bold stripes, trophy glow
- [x] Shiny = piebald (irregular white unpigmented patches over silver/striped body), eye pigmented (not albino)

## Self-assessment (honest)
Every stage rasterized via `qlmanage` and reviewed. All read unambiguously as striped bass —
an angler would say "striper" on sight: the horizontal-stripe count/straightness and the two
separate dorsals are the clinching marks, both present and correct.

Minor stylization notes (intentional cartoon compromises, not errors):
- The dark back margin above the top stripe is a thin band on S2/S3 (stripes sit high on the
  flank). Real stripers do carry stripes high, so this stays within accuracy.
- Soft dorsal reads as a lower rounded lobe vs. the taller spiny dorsal — separation is clear
  at 640px; at very small menubar sizes the two dorsals may visually merge (unavoidable at tiny
  raster sizes, true of any two-dorsal perciform sprite).
