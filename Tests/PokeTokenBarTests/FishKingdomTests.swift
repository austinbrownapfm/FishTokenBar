import XCTest
@testable import PokeTokenBar

/// Tests for the Fish creature kingdom: the save-migration safety net, kingdom switching
/// (park/restore), the bundled FishCatalog data, the honesty guardrails (a real fish GROWS, it
/// never "evolves" into another species), and that bundled swim frames resolve.
final class FishKingdomTests: XCTestCase {

    // MARK: Save migration — a legacy v2.5.2 save has no kingdom fields; NOTHING may be lost.
    // (This is the adversarial review's P0-1: the lenient decoder must not silently zero progress.)
    func testLegacySaveDecodesWithoutLoss() throws {
        let legacy = Data("""
        {"installBaselineSet":true,"usedSinceInstall":1000,"spentTokens":200,
         "inventory":{"rareCandy":2},"collectedFinals":["1:2"],
         "active":{"baseID":1,"pathIDs":[1,2],"plannedPathIDs":[1,2],"stageIndex":0,
                   "usedAtStage":5,"rarity":"common","totalForms":2},
         "dex":[]}
        """.utf8)
        let s = try JSONDecoder().decode(CompanionState.self, from: legacy)
        XCTAssertEqual(s.activeKingdom, .pokemon, "legacy save must default to Pokémon")
        XCTAssertTrue(s.parked.isEmpty)
        XCTAssertEqual(s.usedSinceInstall, 1000)      // global accounting preserved
        XCTAssertEqual(s.spentTokens, 200)
        XCTAssertEqual(s.inventory["rareCandy"], 2)   // working-set fields preserved
        XCTAssertEqual(s.active?.baseID, 1)
        XCTAssertEqual(s.active?.pathIDs, [1, 2])
        XCTAssertTrue(s.collectedFinals.contains("1:2"))
    }

    // MARK: Kingdom switch parks the current progress and restores the other; globals survive.
    func testSwitchKingdomParksAndRestores() {
        var s = CompanionState()
        s.usedSinceInstall = 500
        s.active = MonState(baseID: 1, pathIDs: [1], plannedPathIDs: [1], stageIndex: 0,
                            usedAtStage: 0, rarity: .common, totalForms: 1)
        XCTAssertTrue(s.switchActiveKingdom(to: .fish))
        XCTAssertEqual(s.activeKingdom, .fish)
        XCTAssertNil(s.active, "a never-visited kingdom starts on a fresh egg")
        XCTAssertEqual(s.usedSinceInstall, 500, "global token accounting is not parked")
        XCTAssertEqual(s.parked.map(\.kingdom), [.pokemon])
        XCTAssertEqual(s.parked.first?.active?.baseID, 1)

        // Raise a fish, switch back — Pokémon restored, fish parked.
        s.active = MonState(baseID: 101, pathIDs: [101], plannedPathIDs: [101], stageIndex: 0,
                            usedAtStage: 0, rarity: .common, totalForms: 1)
        XCTAssertTrue(s.switchActiveKingdom(to: .pokemon))
        XCTAssertEqual(s.active?.baseID, 1, "Pokémon working set restored")
        XCTAssertEqual(s.parked.map(\.kingdom), [.fish])
        XCTAssertEqual(s.parked.first?.active?.baseID, 101, "fish progress preserved while parked")
        XCTAssertFalse(s.switchActiveKingdom(to: .pokemon), "switching to the active kingdom is a no-op")
    }

    // MARK: Parked state survives JSON round-trip (as an array, not a positional enum-keyed dict).
    func testSwitchRoundTripsThroughCodable() throws {
        var s = CompanionState()
        s.active = MonState(baseID: 1, pathIDs: [1], plannedPathIDs: [1], stageIndex: 0,
                            usedAtStage: 0, rarity: .common, totalForms: 1)
        s.switchActiveKingdom(to: .fish)
        let round = try JSONDecoder().decode(CompanionState.self, from: JSONEncoder().encode(s))
        XCTAssertEqual(round.activeKingdom, .fish)
        XCTAssertEqual(round.parked.map(\.kingdom), [.pokemon])
        XCTAssertEqual(round.parked.first?.active?.baseID, 1)
    }

    // MARK: FishCatalog — five real species, correct growth shapes, a rarity spread.
    func testFishCatalogStarterDex() async throws {
        let c = FishCatalog()
        XCTAssertEqual(c.species.count, 5)
        let scientific = Set(c.species.map(\.scientificName))
        for name in ["Micropterus nigricans", "Oncorhynchus mykiss", "Lepomis macrochirus",
                     "Morone saxatilis", "Sciaenops ocellatus"] {
            XCTAssertTrue(scientific.contains(name), "missing real species \(name)")
        }
        let rarities = Set(c.species.map(\.rarity))
        XCTAssertTrue(rarities.isSuperset(of: [.common, .uncommon, .rare]), "want a rarity spread")

        // Largemouth: 4 linear life stages; tree NOT pruned by the Pokémon 1…649 sprite filter.
        let lm = try await c.line(baseSpeciesID: 101)
        XCTAssertEqual(lm.tree.depth, 4)
        XCTAssertEqual(lm.tree.finalIDs, [104])
        // Rainbow trout: honest within-species branch (resident 203 / steelhead 204).
        let rt = try await c.line(baseSpeciesID: 201)
        XCTAssertEqual(Set(rt.tree.finalIDs), Set([203, 204]))
        let indexCount = try await c.baseSpeciesIndex().count
        XCTAssertEqual(indexCount, 5)
    }

    // MARK: Every fish "line" is ONE real species — a stage never becomes a different species.
    func testFishLinesAreSingleSpecies() {
        let c = FishCatalog()
        for sp in c.species {
            for st in sp.stages {
                XCTAssertEqual(c.speciesInfo(forStageID: st.id)?.scientificName, sp.scientificName,
                               "\(sp.commonName) stage \(st.label) must stay the same species")
            }
        }
    }

    // MARK: Honesty guardrail — fish progression copy NEVER says "evolve" in ANY language.
    func testFishCopyNeverSaysEvolve() {
        for lang in AppLanguage.allCases {
            let l = L(lang)
            XCTAssertFalse(l.notifGrowTitle.lowercased().contains("evolv"))
            XCTAssertFalse(l.notifGrowBody("Lunker").lowercased().contains("evolv"))
            XCTAssertFalse(l.statusGrewInto("Lunker").lowercased().contains("evolv"))
        }
        XCTAssertTrue(L(.en).notifGrowBody("Lunker").contains("Grew into Lunker"))
        XCTAssertTrue(L(.en).statusGrewInto("Bull Red").contains("Grew into Bull Red"))
    }

    // MARK: Bundled swim frames resolve via Bundle.module (validates the resource wiring).
    @MainActor
    func testFishSwimFramesBundled() {
        let frames = FishSprites.frames(stageID: 103, shiny: false)  // largemouth adult
        XCTAssertEqual(frames.count, FishSprites.frameCount, "largemouth adult must have swim frames")
        XCTAssertFalse(FishSprites.frames(stageID: 404, shiny: true).isEmpty, "striped bass shiny cow frames")
    }

    // MARK: The store switches the active kingdom and updates the render subject.
    @MainActor
    func testStoreSwitchKingdom() {
        let url = FileManager.default.temporaryDirectory
            .appendingPathComponent("ftb-\(UUID().uuidString).json")
        let line = EvoLine(baseID: 1, tree: EvoNode(speciesID: 1, children: []), rarity: .common, names: [:])
        let store = CompanionStore(provider: StubProvider(value: line), fileURL: url, rng: SeededRNG(seed: 3))
        XCTAssertEqual(store.activeKingdom, .pokemon)
        store.switchKingdom(to: .fish)
        XCTAssertEqual(store.activeKingdom, .fish)
        XCTAssertEqual(store.representativeSubject.kingdom, .fish)
        store.switchKingdom(to: .pokemon)
        XCTAssertEqual(store.activeKingdom, .pokemon)
    }

    // MARK: Fish must NOT support the Ditto disguise — it has no species #132, so a rolled disguise
    // would fail its reveal fetch forever and silently brick the fish at its first stage.
    func testFishNeverSupportsDittoDisguise() {
        XCTAssertFalse(FishCatalog().supportsDittoDisguise)
        // The Pokémon catalog keeps it via the protocol default.
        let pokeLine = EvoLine(baseID: 1, tree: EvoNode(speciesID: 1, children: []), rarity: .common, names: [:])
        XCTAssertTrue(StubProvider(value: pokeLine).supportsDittoDisguise)
    }

    // MARK: The growth-line branch "next unknown" node is reachable for fish (Rainbow Trout branches)
    // — its label must never say "evolve"/"진화" (locked honesty mandate, VoiceOver included).
    @MainActor
    func testFishBranchMysteryLabelNeverSaysEvolve() {
        let url = FileManager.default.temporaryDirectory.appendingPathComponent("ftb-\(UUID().uuidString).json")
        let pokeLine = EvoLine(baseID: 1, tree: EvoNode(speciesID: 1, children: []), rarity: .common, names: [:])
        let store = CompanionStore(provider: StubProvider(value: pokeLine), fileURL: url, rng: SeededRNG(seed: 1))
        store.switchKingdom(to: .fish)
        XCTAssertFalse(store.unknownNextLabel.lowercased().contains("evolv"))
        XCTAssertFalse(store.unknownNextLabel.contains("진화"))
    }
}
