import MapKit
import CoreLocation

// MARK: - RouteOverlay

final class RouteOverlay: NSObject, MKOverlay {
    var coordinate: CLLocationCoordinate2D = .init()
    var boundingMapRect: MKMapRect = .world
}
