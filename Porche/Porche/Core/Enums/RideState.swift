import Foundation

/// idle, active, paused, finished
enum RideState: String, Codable {
    case idle
    case active
    case paused
    case finished
}
