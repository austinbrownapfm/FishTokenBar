# Rainbow Trout · FishDex #002 · *Oncorhynchus mykiss* · Salmonidae (Freshwater / anadromous branch)

Hand-authored SVG side-profile sprites, facing RIGHT, 640×400, transparent background.
Consistent flat-cartoon-but-species-accurate style shared across the 5-species set.

## Files
| File | Stage | Read |
|---|---|---|
| `S1.svg` | S1 Alevin/Fry (1–3 in) | tiny, slender, oversized eye, faint parr marks, faint pink wash |
| `S2.svg` | S2 Parr (3–8 in) | slender, grey-blue oval parr marks, spots forming |
| `S3a.svg` | S3a Resident Rainbow (branch, 10–18 in) | olive back, dense black spots, magenta-pink stripe, silver flank |
| `S3b.svg` | S3b Steelhead (branch, sea-run) | chrome-silver, gunmetal back, faded spots, faint pink stripe |
| `S3a-shiny.svg` | Shiny = Golden Rainbow / Palomino | golden-yellow body, retained pink stripe, sparse faint brown spots, NORMAL pigmented eyes |

Branch note (S3a vs S3b): SAME species, "went to sea / stayed home" gate — NOT a species change.
Shiny is the real hatchery melanophore-reduction morph (palomino), NOT the separate CA Golden Trout species; eyes are pigmented (not albino).

## Animation rig (IDs + pivots) — identical rig contract across all stages
| Group | Role | data-pivot (per file) |
|---|---|---|
| `#body` | body + head + eye + dorsal/adipose/pelvic/anal + markings | — |
| `#tail` | caudal fin only | S3a/shiny `112,200` · S3b `110,200` · S2 `137,200` · S1 `230,200` |
| `#pecfin` | pectoral fin | S3a/shiny/S3b `472,210` · S2 `466,214` · S1 `452,206` |

Pivots sit at the caudal peduncle (tail) and pectoral base; geometry is visually continuous across each pivot so a ±10° rotation leaves no gap.

## Palette (hex)
### S3a Resident Rainbow (master)
- Olive back: `#6E8150`  · flank sheen gradient `#EEF3F4 → #D3DEE1 → #EAF0EE` · pale belly `#F4F6F1`
- Magenta-pink stripe: `#E24A8C` core, `#F27CB2`/`#F79ECB` highlight, `#C43A76` shade
- Black spots: `#1F2620`  · outline `#33402C`
- Fins olive: dorsal `#8B9C68`, tail `#8FA06A`, adipose `#7E8F5C`; lower fins warm hyaline `#D9B7B0`
- Eye: sclera `#EFE6C9`, gold iris `#C9A24B`, pupil `#16181A`, catchlight `#FFFFFF`

### S3b Steelhead
- Gunmetal back `#6C8494` · chrome gradient `#F6FAFB → #DFE9ED → #EAF2F4 → #FAFDFD` · white belly `#FCFEFE`
- Faded spots `#4A5560` (opacity ~0.55) · faint rose stripe `#D98AA8` (opacity 0.38) · outline `#465562` · fins `#C6D2D8`/`#CDD8DD`

### S3a-shiny Golden Rainbow / Palomino
- Amber back `#E4A62E` · gold gradient `#FCEFB6 → #F6D869 → #FDF3C8` · cream belly `#FEF8E0`
- Retained pink stripe `#E56C9E` (softened) · sparse faint brown spots `#7A5A1B` (opacity 0.4) · outline `#A9791F` · fins `#F0CE70`/`#F5DE93`
- Eye: NORMAL pigment — gold iris `#C9A24B`, black pupil `#16181A`

### S2 Parr
- Olive back `#7C8A62` · silver gradient `#EEF2EE → #D6DED9 → #EDF1EC` · pale belly `#F2F4EE`
- Parr marks grey-blue `#6B7E92` (opacity 0.82) · forming spots `#232A22` · faint pink hint `#E88FB4` (0.28) · outline `#3C4832`

### S1 Fry
- Soft olive back `#9BA794` · translucent gradient `#EEF4F5 → #DCE6E8 → #F4F8F7` · belly `#F6FAF9`
- Faint parr marks `#728697` (0.5) · faint pink wash `#EF9BBE` (0.3) · outline `#556561`; big pupil `#16181A`, catchlight `#FFFFFF`

## Accuracy checklist (dex diagnostic marks)
- [x] Torpedo / fusiform body (all adult+juvenile stages; slimmer for parr/fry)
- [x] DENSE small black spots over back, dorsal fin AND tail (S3a) — faded on steelhead, sparse/brown on palomino, forming on parr
- [x] MAGENTA-PINK lateral stripe (S3a vivid; steelhead faint rose; palomino retained; parr/fry faint wash)
- [x] Silvery flank with sheen gradient
- [x] **Adipose fin present between dorsal and tail — the salmonid signature (present in ALL 5 stages, incl. fry)**
- [x] Squared / slightly-forked caudal tail (center notch, squared lobe tips)
- [x] Pectoral + pelvic + anal + single dorsal fins present and correctly placed
- [x] Friendly rounded eye with catchlight; cel-shaded countershading (dark back → pale belly)
- [x] Parr (S2): slender body + row of grey-blue oval parr marks
- [x] Steelhead (S3b): chrome-silver, gunmetal back, faded spots, faint stripe, streamlined (sea-run sheen)
- [x] Shiny = Palomino/Golden Rainbow, NORMAL pigmented eyes (not albino), NOT CA Golden Trout species
- [x] Facing RIGHT, ~65–80% canvas width, fins unclipped, transparent background
- [x] Required rig groups `#body`, `#tail` (data-pivot), `#pecfin` (data-pivot) on every file

## Self-assessment (honest)
Rendered each via `qlmanage` and reviewed. All five read instantly as rainbow trout / steelhead to an
angler: the spot density + magenta stripe + adipose fin + squared tail nail the S3a diagnosis; steelhead
correctly de-saturates to chrome; palomino is unmistakably the golden hatchery morph with eyes intact;
parr shows the classic oval parr-mark row; fry is a believable translucent big-eyed fingerling that still
carries the salmonid adipose fin. Stylistic (flat cartoon), but silhouette, fins, and markings are
species-accurate. Minor liberties: pink stripe on S3a is slightly candy-bright vs. a real diffuse rose
band (kept for instant recognition), and a few flank spots sit below the lateral line (rainbow trout do
spot the flank, so within tolerance).
