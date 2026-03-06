import Foundation
import MapKit
import CoreLocation

// MARK: - LocationConstants

enum LocationConstants {
    static let croatiaRegion: MKCoordinateRegion = {
        let center = CLLocationCoordinate2D(latitude: 45.1, longitude: 15.2)
        return MKCoordinateRegion(
            center: center,
            span: MKCoordinateSpan(latitudeDelta: 6, longitudeDelta: 8)
        )
    }()
}
