# Largemouth Bass · FishDex #001 — Sprite Notes

*Micropterus nigricans* · Centrarchidae · Freshwater · FW Line 1.
All sprites: 640×400 viewBox, transparent bg, fish faces RIGHT, hand-authored SVG.
Rig groups present in every file: `#body`, `#tail` (data-pivot), `#pecfin` (data-pivot).

## Files
| File | Stage | Notes |
|---|---|---|
| `S1.svg` | Fry | translucent-olive comma, huge eye, visible yolk sac, larval finfold |
| `S2.svg` | Fingerling | slim silver-olive minnow, BOLD solid black midline stripe, oversized eye, caudal spot |
| `S3.svg` | Adult (Keeper) | deep olive body, cream belly, broken jagged band, huge gaping jaw past eye |
| `S4.svg` | Lunker (Trophy) | pot-bellied, darker, battle scars, heavy mottled band, golden rim-light |
| `S4-shiny.svg` | Lunker — golden/xanthic morph | yellow-gold body, NORMAL amber eye (not albino), ghost band |

## Animation-rig pivots (data-pivot="PX,PY")
| File | `#tail` pivot | `#pecfin` pivot |
|---|---|---|
| S1 | 205,204 | 424,214 |
| S2 | 160,201 | 456,208 |
| S3 | 152,199 | 450,208 |
| S4 | 150,204 | 452,212 |
| S4-shiny | 150,204 | 452,212 |

Tail pivots sit at the caudal peduncle where the fin's leading edge overlaps the body
(fin drawn ~8px into the body so no gap opens when rotated ±10°). Pecfin pivots sit at the
fin base on the flank.

## Palette (hex)

### Body countershading gradient (dark back → cream belly)
- Adult S3: `#3a5426` → `#6d8c3e` → `#a9bd72` → `#ddd2ab` → `#f0e8cc`
- Lunker S4 (darker/deeper): `#2c451c` → `#54782e` → `#8fa657` → `#cabf93` → `#e7deba`
- Fingerling S2 (muted silver-olive): `#5f7440` → `#8a9a63` → `#c3c6a4` → `#e7e7d3`
- Fry S1 (translucent): `#7e9159` → `#a9b689` → `#d6dcc2` (fill-opacity ~0.9)
- Shiny xanthic S4: `#b3801a` → `#d8a82c` → `#eecb57` → `#f7e293` → `#fdf3c6`

### Markings / features
- Lateral band (broken blotches): `#263617` / `#22331590` (S3/S4)
- Juvenile solid midline stripe + caudal spot: `#1c2712`
- Fins (olive): `#48602a`→`#83a052` (S3), `#3c521f`→`#6f8c43` (S4)
- Outline: `#28381a` (S3) / `#243315` (S4) / `#31441f` (S2) / `#5f7440` (S1)
- Eye: sclera `#f2ecd0`, iris `#b58a2c` (amber), pupil `#141008`, catchlight `#ffffff`
- Mouth interior: `#20160f` / `#1d140d`
- Yolk sac (fry): radial `#ffe0a0`→`#f2b957`→`#dd9a3a`
- Trophy rim-light: `#f0e39a` (S4) / `#fff6cf` (shiny)
- Shiny outline / detail: `#8a6416`, mouth `#5a3a12`

## Species-accuracy checklist
- [x] Deep olive-green body + cream belly (countershading gradient, all adult stages)
- [x] BROKEN blotchy dark lateral band (jagged irregular blotches, S3/S4)
- [x] LARGE mouth — open terminal gape, jaw hinge extends PAST (behind) the eye (S3/S4)
- [x] Near-separated spiny + soft dorsal (deep notch between the two membraned fins)
- [x] Correct fin set: spiny+soft dorsal, pectoral, pelvic, anal, slightly-forked caudal
- [x] Body deepens & darkens fingerling → lunker (S2 slim/pale → S3 deep → S4 pot-bellied/dark)
- [x] Juvenile diagnostic: bold SOLID (unbroken) black midline stripe on the fingerling
- [x] Fry: translucent, oversized eye, visible yolk sac, barely-fish comma shape
- [x] Shiny = golden/xanthic (yellow-gold, NORMAL pigmented eye — not albino)
- [x] Faces RIGHT, fills ~80% width, transparent background, fins not clipped
- [x] Rig groups (#body, #tail+pivot, #pecfin+pivot) in every file; tail overlaps body at pivot

## Self-assessment (honesty)
- **S3 Adult** — strongest. Big open jaw + hinge-past-eye and the jagged broken band are
  unmistakable largemouth marks. An angler reads it instantly.
- **S4 Lunker** — reads as a distinctly heavier/darker "big old fish" vs the keeper; scars +
  golden rim-light sell the trophy without cartoon glow.
- **S4-shiny** — clean recolor; keeps the amber eye so it is xanthic (real VA-2023 morph), not albino.
- **S2 Fingerling** — the bold continuous midline stripe is the correct juvenile cue and clearly
  differentiates it from the broken-band adult; slimmer/paler body sells the life-stage shift.
- **S1 Fry** — larval proportions (dominant eye, yolk sac, comma taper) read as a fry, not a
  mini-adult. Deliberately lacks true fins (continuous finfold) per larval anatomy.
- Minor: the spiny dorsal on smaller stages is compact; pelvic fins are intentionally small
  (correct for the species) so they read as short tabs rather than large fins.
