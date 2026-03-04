import Foundation
import CoreLocation

struct RouteModel: Identifiable, Codable {
    let id: UUID
    var name: String
    var waypoints: [CLLocationCoordinate2D]
    var elevationProfile: [Double]
}
