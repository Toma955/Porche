import Foundation

// MARK: - BikeError

enum BikeError: Error {
    case connectionLost
    case motorFault
    case lowBattery
    case overheating
    case unknown
}
