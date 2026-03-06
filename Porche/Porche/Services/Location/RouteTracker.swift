import Foundation
import CoreLocation

// MARK: - RouteTracker

final class RouteTracker {
    func startTracking() {}
    func stopTracking() {}
    var currentPath: [CLLocation] { [] }
}
