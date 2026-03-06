import MapKit
import CoreLocation

// MARK: - POIAnnotation

final class POIAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var poiType: POIType = .cafe
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
