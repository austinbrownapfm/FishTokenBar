import Foundation

/// A "creature kingdom" — the pluggable species world the companion belongs to.
///
/// The app started as Pokémon-only; `fish` adds real angler fish (see `FishCatalog`).
/// New kingdoms drop in by (1) adding a case here, (2) providing a `SpeciesCatalog`
/// and registering it in `CompanionStore`'s catalog resolver, (3) bundling sprite
/// frames under `Resources/<rawValue>/`. No changes to the token economy, floating
/// pet, menu bar, or persistence are needed — the parked-kingdom save model (see
/// `CompanionState`) preserves each kingdom's progress independently.
///
/// `rawValue` is the stable on-disk + sprite-namespace key. NEVER rename a case's
/// rawValue without a save migration — it keys parked state and the sprite cache.
enum Kingdom: String, Codable, CaseIterable, Sendable {
    case pokemon
    case fish

    /// Presented name (localized copy lives in `Localization`; this is the neutral fallback).
    var displayName: String {
        switch self {
        case .pokemon: return "Pokémon"
        case .fish: return "Fish"
        }
    }

    /// The default kingdom for a fresh install and for any legacy save that predates
    /// the kingdom field — must stay `.pokemon` so existing users are unaffected.
    static let legacyDefault: Kingdom = .pokemon
}
