import MapKit
import CoreLocation

final class BikeAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
