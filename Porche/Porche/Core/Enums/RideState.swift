import Foundation

// MARK: - RideState

enum RideState: String, Codable {
    case idle
    case active
    case paused
    case finished
}
