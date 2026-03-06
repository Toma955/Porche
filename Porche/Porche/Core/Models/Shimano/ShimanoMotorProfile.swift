import Foundation

// MARK: - ShimanoMotorProfile

struct ShimanoMotorProfile: Identifiable {
    let id: UUID
    var name: String
    var isFineTune: Bool
    var torqueSettings: [AssistMode: Int]
}
