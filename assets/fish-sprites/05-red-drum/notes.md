# Red Drum (Redfish) · FishDex #005 · SW — Sprite Notes

*Sciaenops ocellatus* · Sciaenidae. Saltwater line 2. Faces RIGHT, 640×400, transparent bg.

## Files
| File | Stage | Read |
|---|---|---|
| `S1.svg` | Marsh Juvenile (<4–10 in) | slim/elongated, muted pale bronze, oversized eye, 1 tail spot |
| `S2.svg` | Slot Redfish (18–27 in) | copper-bronze back, white belly, single bold ocellus |
| `S3.svg` | Bull Red / Trophy (28–50+ in) | deep heavy body, rich deep copper, MULTIPLE (3) tail spots |
| `S3-shiny.svg` | Bull Red — Xanthic morph | vivid gold/orange body, NORMAL dark eye, spots retained |

## Palette (hex)
**S2 Slot (baseline copper)**
- Body gradient (back→belly): `#8F5019` → `#BE7431` → `#D6944B` → `#E9C287` → `#FAF1E1`
- Back countershade wash: `#7C4416` @35% · lateral sheen: `#F2D49B` @45%
- Fins: `#A55E26`→`#CD8A48` · Tail: `#B06A2C`→`#C98A48`
- Outline: `#5E3212` · Eye iris `#231407`, sclera `#FBF3E4`, catchlight `#FFFFFF`
- Ocellus: black `#141210` on pale halo `#FBF1DE`

**S1 Juvenile (muted / paler)**
- Body: `#9C6C3E` → `#C0925F` → `#D6B384` → `#EEDDC4` → `#FCF7EF`
- Outline `#6B4420` · fins `#B07E4A`→`#D3AE7D`

**S3 Bull (saturated deep copper)**
- Body: `#7C3D0F` → `#B25B1D` → `#CE7A2B` → `#E3A24F` → `#F1CE90` → `#FBF2DF`
- Outline `#5A2E0C` · fins `#93490F`→`#C27B34` · countershade `#6E3A0F` @34%

**S3-shiny Xanthic (gold/orange)**
- Body: `#E4670F` → `#F5891E` → `#FBA531` → `#FDC152` → `#FEDE93` → `#FFF7E4`
- Outline `#9A4D06` · fins `#EC7A14`→`#FBBB52` · sheen `#FFEFBE` @50%
- Eye kept NORMAL dark (`#1F1206`) — xanthic, not albino. Melanin ocelli retained.

## Animation rig — group IDs + pivots
All files expose `#body`, `#tail` (data-pivot), `#pecfin` (data-pivot).
Ocellus/markings/dorsal/anal/pelvic fins live inside `#body`; caudal fin isolated in `#tail`.

| File | tail data-pivot (peduncle) | pecfin data-pivot (fin base) |
|---|---|---|
| S1 | `117,198` | `498,210` |
| S2 | `117,197` | `496,206` |
| S3 | `115,201` | `494,214` |
| S3-shiny | `115,201` | `494,214` |

Tail geometry meets body at the peduncle (x≈114–118) with no gap under ±10° wag; pectoral base tucked just behind the gill-cover line.

## Species-accuracy checklist
- [x] Coppery-bronze / reddish-gold body (deepens juvenile→bull)
- [x] White/cream belly via countershading gradient
- [x] SIGNATURE bold BLACK EYESPOT (ocellus) near tail base — 1 on S1 & S2, 3 on S3/shiny
- [x] Ocellus has pale halo so black spot pops against copper flank
- [x] Slightly blunt / rounded head
- [x] Slightly forked / squared caudal tail (shallow central notch)
- [x] Sub-terminal mouth pointing slightly down (bottom-feeder)
- [x] Long dorsal fin, spiny front + soft rear (Sciaenidae)
- [x] Body depth increases: slim juvenile → medium slot → deep-bellied bull
- [x] One friendly rounded eye with catchlight; normal (non-albino) even on shiny
- [x] Faces RIGHT, ~80% width, fins unclipped, transparent bg
- [x] Shiny = documented xanthic morph (gold/orange, normal eyes)
```
