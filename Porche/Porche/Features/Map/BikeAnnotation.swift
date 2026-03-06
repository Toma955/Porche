import MapKit
import CoreLocation

// MARK: - BikeAnnotation

final class BikeAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
