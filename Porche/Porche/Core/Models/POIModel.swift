import Foundation
import CoreLocation

struct POIModel: Identifiable, Codable {
    let id: UUID
    var name: String
    var type: POIType
    var coordinate: CLLocationCoordinate2D
}
