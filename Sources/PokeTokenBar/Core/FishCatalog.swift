import Foundation

/// Where a species lives. Purely descriptive (dex flavor); not used by the token economy.
enum WaterType: String, Codable, Sendable {
    case freshwater, saltwater, anadromous
    var label: String {
        switch self {
        case .freshwater: return "Freshwater"
        case .saltwater: return "Saltwater"
        case .anadromous: return "Anadromous"
        }
    }
}

/// One life stage of a real fish. The app maps the Pokémon "evolution" mechanic onto HONEST
/// within-species life-stage growth (fry → juvenile → adult → trophy), so a stage is NOT a new
/// species — it is the same fish, older and bigger. Player-facing copy must say "grows into",
/// never "evolves into" (see `Localization` fish vocabulary + `CopyGuardrail`).
struct FishStageInfo: Sendable, Equatable {
    let id: Int          // kingdom-local species id (namespaced per species, e.g. 101…104)
    let label: String    // "Fry", "Lunker (Trophy)" — the growth-stage name
    let size: String     // "20–25 in · 8–12 lb"
    let flavor: String   // accurate one-liner (dex entry)
    let spriteFile: String // SVG/PNG stage basename, e.g. "S1", "S3a"
    let branchGroup: String? // "resident"/"steelhead" for the O. mykiss split; else nil
}

/// A real fish species and its life-stage growth line. One species == one dex line; it never
/// turns into another species. Cross-species groupings (if added) are "Collections", not evolution.
struct FishSpeciesInfo: Sendable {
    let dexNumber: Int          // display #001…#005
    let baseID: Int             // kingdom-local base species id (start of the growth line)
    let commonName: String
    let scientificName: String
    let family: String
    let water: WaterType
    let nativeRange: String
    /// Drives `Rarity` (via `Rarity.from`) and hatch weighting, exactly like PokéAPI capture_rate.
    /// ≤45 rare · ≤120 uncommon · else common. Chosen for a common/uncommon/rare spread.
    let captureRate: Int
    let stages: [FishStageInfo] // ordered by growth
    let tree: EvoNode           // growth tree (linear, or branched for Rainbow Trout)
    let shinyMorph: String      // real rare color morph name, e.g. "Golden / Xanthic"
    let dirSlug: String         // sprite dir, e.g. "01-largemouth-bass"

    var stageByID: [Int: FishStageInfo] {
        Dictionary(uniqueKeysWithValues: stages.map { ($0.id, $0) })
    }
    var rarity: Rarity { Rarity.from(captureRate: captureRate, isLegendary: false, isMythical: false) }
}

/// Bundled, offline species-data source for the Fish kingdom — the angler-fish analog of
/// `PokeAPIClient`. Conforms to the same `PokeProviding` seam so `CompanionStore` raises fish with
/// the identical hatch/grow/graduate engine (no network). All species are REAL; content verified in
/// `.fishplan/fish-dex.md`. Bulk static data lives here (a non-LOGIC_CORE file) to avoid diluting
/// the coverage gate's denominator.
final class FishCatalog: PokeProviding, @unchecked Sendable {
    static let shared = FishCatalog()

    let species: [FishSpeciesInfo]
    private let byBaseID: [Int: FishSpeciesInfo]
    private let byStageID: [Int: FishSpeciesInfo]

    init(species: [FishSpeciesInfo] = FishCatalog.starterDex) {
        self.species = species
        self.byBaseID = Dictionary(uniqueKeysWithValues: species.map { ($0.baseID, $0) })
        var stageMap: [Int: FishSpeciesInfo] = [:]
        for sp in species { for st in sp.stages { stageMap[st.id] = sp } }
        self.byStageID = stageMap
    }

    // MARK: Lookups (used by sprite loader, dex UI, growth vocabulary)

    func speciesInfo(baseID: Int) -> FishSpeciesInfo? { byBaseID[baseID] }
    func speciesInfo(forStageID id: Int) -> FishSpeciesInfo? { byStageID[id] }
    func stageInfo(id: Int) -> FishStageInfo? { byStageID[id]?.stageByID[id] }

    // MARK: PokeProviding

    func line(baseSpeciesID: Int) async throws -> EvoLine {
        guard let sp = byBaseID[baseSpeciesID] else { throw URLError(.fileDoesNotExist) }
        // Names: fish are English-only in the spec; rely on the same English fallback the app uses
        // for Portuguese Pokémon names. Every stage id carries the species common name.
        var names: [Int: [String: String]] = [:]
        for st in sp.stages { names[st.id] = ["en": sp.commonName] }
        // filterAnimated:false — fish ship bundled sprites for every stage; do NOT prune to 1…649.
        return EvoLine(baseID: sp.baseID, tree: sp.tree, rarity: sp.rarity, names: names,
                       filterAnimated: false)
    }

    func baseSpeciesIndex() async throws -> [BaseSpecies] {
        species.map { BaseSpecies(id: $0.baseID, captureRate: $0.captureRate) }
    }

    func baseSpecies(id: Int) async throws -> BaseSpecies? {
        byBaseID[id].map { BaseSpecies(id: $0.baseID, captureRate: $0.captureRate) }
    }

    // MARK: Tree helpers

    /// Build a linear growth chain (fry → … → trophy) from an ordered list of stage ids.
    private static func chain(_ ids: [Int]) -> EvoNode {
        guard let head = ids.first else { return EvoNode(speciesID: 0, children: []) }
        let rest = Array(ids.dropFirst())
        return EvoNode(speciesID: head, children: rest.isEmpty ? [] : [chain(rest)])
    }

    // MARK: Starter Fish Dex (3 freshwater + 2 saltwater; all species real — see .fishplan/fish-dex.md)

    static let starterDex: [FishSpeciesInfo] = [
        // #001 Largemouth Bass — common freshwater icon
        FishSpeciesInfo(
            dexNumber: 1, baseID: 101, commonName: "Largemouth Bass",
            scientificName: "Micropterus nigricans", family: "Centrarchidae",
            water: .freshwater, nativeRange: "North America", captureRate: 130,
            stages: [
                FishStageInfo(id: 101, label: "Fry", size: "0.15–1 in",
                    flavor: "Yolk-sac fry guarded on the nest — feeds first on its yolk, then zooplankton.",
                    spriteFile: "S1", branchGroup: nil),
                FishStageInfo(id: 102, label: "Fingerling", size: "1–4 in · <0.1 lb",
                    flavor: "A summer-old juvenile with a bold dark midline stripe that fades with age.",
                    spriteFile: "S2", branchGroup: nil),
                FishStageInfo(id: 103, label: "Adult (Keeper)", size: "10–18 in · 0.5–4 lb",
                    flavor: "Mature. The jaw hinge extends past the eye — the mark of a largemouth.",
                    spriteFile: "S3", branchGroup: nil),
                FishStageInfo(id: 104, label: "Lunker (Trophy)", size: "20–25 in · 8–12+ lb",
                    flavor: "A rare heavyweight female. 'Lunker' is angler slang, not a life stage.",
                    spriteFile: "S4", branchGroup: nil),
            ],
            tree: chain([101, 102, 103, 104]),
            shinyMorph: "Golden / Xanthic", dirSlug: "01-largemouth-bass"),

        // #002 Rainbow Trout — uncommon; real within-species branch (resident vs sea-run steelhead)
        FishSpeciesInfo(
            dexNumber: 2, baseID: 201, commonName: "Rainbow Trout",
            scientificName: "Oncorhynchus mykiss", family: "Salmonidae",
            water: .anadromous, nativeRange: "Pacific North America", captureRate: 100,
            stages: [
                FishStageInfo(id: 201, label: "Alevin / Fry", size: "1–3 in",
                    flavor: "Young-of-year in cool, oxygen-rich streams.",
                    spriteFile: "S1", branchGroup: nil),
                FishStageInfo(id: 202, label: "Parr", size: "3–8 in",
                    flavor: "Juvenile with dark oval 'parr marks' for camouflage.",
                    spriteFile: "S2", branchGroup: nil),
                FishStageInfo(id: 203, label: "Resident Rainbow", size: "10–18 in · 1–5 lb",
                    flavor: "Stream/lake resident — keeps the vivid pink-red band year-round.",
                    spriteFile: "S3a", branchGroup: "resident"),
                FishStageInfo(id: 204, label: "Steelhead", size: "18–24 in · 4–11 lb",
                    flavor: "The same fish gone to sea — returns chrome-bright and larger to spawn.",
                    spriteFile: "S3b", branchGroup: "steelhead"),
            ],
            tree: EvoNode(speciesID: 201, children: [
                EvoNode(speciesID: 202, children: [
                    EvoNode(speciesID: 203, children: []),
                    EvoNode(speciesID: 204, children: []),
                ]),
            ]),
            shinyMorph: "Golden Rainbow / Palomino", dirSlug: "02-rainbow-trout"),

        // #003 Bluegill — common panfish (it IS a sunfish)
        FishSpeciesInfo(
            dexNumber: 3, baseID: 301, commonName: "Bluegill",
            scientificName: "Lepomis macrochirus", family: "Centrarchidae",
            water: .freshwater, nativeRange: "North America", captureRate: 255,
            stages: [
                FishStageInfo(id: 301, label: "Fry", size: "<1 in",
                    flavor: "Hatched in a male-guarded nest in the shallows.",
                    spriteFile: "S1", branchGroup: nil),
                FishStageInfo(id: 302, label: "Juvenile Panfish", size: "3–5 in",
                    flavor: "Deep, flat-sided panfish body; may mature this small.",
                    spriteFile: "S2", branchGroup: nil),
                FishStageInfo(id: 303, label: "Breeding Male", size: "6–8 in",
                    flavor: "Spawning males turn blue-green with a rusty-orange breast and black ear flap.",
                    spriteFile: "S3", branchGroup: nil),
                FishStageInfo(id: 304, label: "Bull Bluegill (Trophy)", size: "9–12 in · 1–2 lb",
                    flavor: "A thick 'bull' bluegill — a rare trophy prized by panfish anglers.",
                    spriteFile: "S4", branchGroup: nil),
            ],
            tree: chain([301, 302, 303, 304]),
            shinyMorph: "Piebald", dirSlug: "03-bluegill"),

        // #004 Striped Bass — rare, anadromous saltwater gamefish
        FishSpeciesInfo(
            dexNumber: 4, baseID: 401, commonName: "Striped Bass",
            scientificName: "Morone saxatilis", family: "Moronidae",
            water: .anadromous, nativeRange: "Atlantic coast of North America", captureRate: 40,
            stages: [
                FishStageInfo(id: 401, label: "Juvenile", size: "2–12 in",
                    flavor: "Rears 2–4 years in estuaries and rivers before moving to the coast.",
                    spriteFile: "S1", branchGroup: nil),
                FishStageInfo(id: 402, label: "Schoolie", size: "12–25 in · 0.5–6 lb",
                    flavor: "Angler term for smaller, school-running fish.",
                    spriteFile: "S2", branchGroup: nil),
                FishStageInfo(id: 403, label: "Adult", size: "24–40 in · 5–30 lb",
                    flavor: "Mature — runs up rivers to spawn.",
                    spriteFile: "S3", branchGroup: nil),
                FishStageInfo(id: 404, label: "Cow (Trophy)", size: "45–50+ in · 40–50+ lb",
                    flavor: "A trophy 'cow' — the biggest stripers are all females.",
                    spriteFile: "S4", branchGroup: nil),
            ],
            tree: chain([401, 402, 403, 404]),
            shinyMorph: "Piebald", dirSlug: "04-striped-bass"),

        // #005 Red Drum (Redfish) — rare saltwater icon
        FishSpeciesInfo(
            dexNumber: 5, baseID: 501, commonName: "Red Drum",
            scientificName: "Sciaenops ocellatus", family: "Sciaenidae",
            water: .saltwater, nativeRange: "Gulf & Atlantic coasts", captureRate: 45,
            stages: [
                FishStageInfo(id: 501, label: "Marsh Juvenile", size: "<4–10 in",
                    flavor: "Rears in marsh grass and tidal creeks; already shows the tail spot.",
                    spriteFile: "S1", branchGroup: nil),
                FishStageInfo(id: 502, label: "Slot Redfish", size: "18–27 in · 2–5 lb",
                    flavor: "'Slot' is a harvest-size rule, not a life stage.",
                    spriteFile: "S2", branchGroup: nil),
                FishStageInfo(id: 503, label: "Bull Red (Trophy)", size: "28–50+ in · 8–40+ lb",
                    flavor: "A mature 'bull' red — moves nearshore to spawn, often with several tail spots.",
                    spriteFile: "S3", branchGroup: nil),
            ],
            tree: chain([501, 502, 503]),
            shinyMorph: "Xanthic", dirSlug: "05-red-drum"),
    ]
}
