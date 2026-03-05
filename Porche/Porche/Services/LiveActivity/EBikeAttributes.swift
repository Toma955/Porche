import Foundation
import ActivityKit
struct EBikeAttributes: ActivityAttributes {
    struct ContentState: Codable, Hashable {
        var speed: Double
        var batteryPercent: Int
        var assistMode: String
    }
    var rideId: String
}
