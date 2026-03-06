import Foundation

// MARK: - Rider

struct Rider: Identifiable, Codable {
    let id: UUID
    var name: String
    var weight: Double
    var preferredUnit: UnitSystem
}
