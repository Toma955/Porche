import Foundation

/// Profil 1 (Standard) i Profil 2 (Fine Tune)
struct ShimanoMotorProfile: Identifiable {
    let id: UUID
    var name: String
    var isFineTune: Bool
    var torqueSettings: [AssistMode: Int]
}
