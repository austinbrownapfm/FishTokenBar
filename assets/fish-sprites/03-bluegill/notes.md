# Bluegill · FishDex #003 — Sprite Notes

*Lepomis macrochirus* · Centrarchidae (a true sunfish) · Freshwater · FW LINE 3.
All sprites: 640×400 viewBox, faces RIGHT, transparent background, hand-authored SVG.
Required animation-rig groups present in every file: `#body`, `#tail` (data-pivot), `#pecfin` (data-pivot).

## Files
| File | Stage | Notes |
|---|---|---|
| `S1.svg` | Fry (<1 in) | Tiny, drab translucent-olive, oversized eye, faint bars, minimal fins |
| `S2.svg` | Juvenile Panfish (3–5 in) | Canonical olive disc; 6 faint vertical bars; small dark ear flap |
| `S3.svg` | Breeding Male (6–8 in) | Dark blue-green back, coppery-orange breast, blue-purple face, bold black flap |
| `S4.svg` | Bull Bluegill / Trophy (9–12 in) | Deepest/thickest body, forehead (nuchal) hump, intense color, big black flap |
| `S4-shiny.svg` | Trophy — Piebald morph | S4 geometry + irregular white unpigmented patches over normal breeding color |

## Animation-rig pivots (data-pivot on the group)
| File | `#tail` pivot | `#pecfin` pivot |
|---|---|---|
| S1 | 260,203 | 352,214 |
| S2 | 158,205 | 446,192 |
| S3 | 158,205 | 446,192 |
| S4 | 156,205 | 448,200 |
| S4-shiny | 156,205 | 448,200 |

Pivots sit at the caudal peduncle (tail↔body join) and at the pectoral-fin base, so a ±10° rotation
stays visually continuous with no gap at the seam.

## Palette (hex)

### Shared / structural
- Outline (adult olive): `#2C3519` · (breeding/bull darker): `#182517` / `#0E1E18`
- Black opercular EAR FLAP: `#16181A` (juv) · `#101113` (breeding) · `#0C0D0F` (bull), stroke `#000000`
- Eye sclera ring: `#F2ECD6` / `#E6DBBE`; catchlight `#FFFFFF`; pupil `#141210`
- Iris: amber `#C7912E` (juv) → rusty `#B4471F`/`#A83C16` (breeding/bull)

### S1 Fry (pale, translucent)
- Body gradient `#8FA06C → #B7C48E → #E4E7C8` (fill-opacity 0.92) · bars `#6E7C4C` @0.20 · outline `#5D6B42`

### S2 Juvenile (olive disc, countershaded)
- Flank gradient `#4E6033`(back) → `#7E9350` → `#B7C179` → `#E9E2BE`(belly)
- Vertical bars `#3F5228` @0.26 · fins `#5F7239` / `#6E8043` · belly wash `#EDE7C8`

### S3 Breeding Male
- Flank gradient `#243D33` → `#3C5A3E` → `#5E7A44` → `#9C7A3C` → `#C97A34`
- Coppery-orange breast `#E68A34 → #CE6E28` · blue-purple face `#4E6FB0 → #3A5488`
- Bars `#1E3226` @0.34 · fins `#3B5340`

### S4 Bull (Trophy) & S4-shiny
- Flank gradient `#182E2C` → `#284A3A` → `#4E6E40` → `#9A6E2E` → `#C0611E`
- Breast `#EE8226 → #CB5E18` · face `#5470BE → #374F8E` · nuchal-hump sheen `#6E88C0` @0.55
- Bars `#0F2620` @0.36 · fins `#2E4A3A`/`#33473A`
- Piebald patches (shiny only): `#F4F1E5` fill, edge `#C6C4AC` (color retained underneath = piebald, not leucistic)

## Species-accuracy checklist (dex diagnostic marks)
- [x] DEEP, ROUND, laterally-compressed DISC body — depth ≈ 0.60–0.68 of length (panfish signature, NOT torpedo)
- [x] 5–9 faint VERTICAL bars (6 drawn per adult stage, low-opacity, curved to follow body)
- [x] SOLID BLACK opercular "ear" flap at the rear edge of the gill cover, at eye level, projecting back
- [x] Small POINTED pectoral fin (own rigged group, pivot at base)
- [x] Single CONTINUOUS dorsal fin — spiny triangular front + rounded soft rear
- [x] Anal fin (spiny + soft) mirroring the soft dorsal on the ventral rear
- [x] Small thoracic pelvic fin
- [x] Moderately FORKED / emarginate caudal tail
- [x] Small terminal mouth; single friendly rounded eye with catchlight
- [x] S3 Breeding Male: coppery-orange breast + blue-purple face + intense saturated color
- [x] S4 Bull: very deep/thick body + forehead (nuchal) hump, most saturated
- [x] Cel shading: dark back → pale belly countershading + subtle flank sheen gradient
- [x] Shiny = piebald (irregular white unpigmented patches over normal breeding color)

## Self-assessment (honest)
Every stage rasterized via `qlmanage` and reviewed. All read immediately as bluegill/sunfish: the
round laterally-compressed disc silhouette is the dominant cue, reinforced by the black ear flap and
vertical bars. S3 and S4 are unmistakable breeding/bull bluegill (blue face, copper breast). The bull's
forehead hump is carried mostly by the nape profile bulge + blue sheen highlight — present and reading,
though subtler than a cartoon caricature would push it. Fry is intentionally drab/tiny with an oversized
eye. No water/scene/text; fins clear of canvas edges. Coherent single-artist cel style across the line.
