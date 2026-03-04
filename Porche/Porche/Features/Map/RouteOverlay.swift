import MapKit
import CoreLocation

final class RouteOverlay: NSObject, MKOverlay {
    var coordinate: CLLocationCoordinate2D = .init()
    var boundingMapRect: MKMapRect = .world
}
