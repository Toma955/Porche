import Foundation
import CoreLocation

// MARK: - LocationManager

final class LocationManager: NSObject, ObservableObject {
    private let manager = CLLocationManager()
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    @Published var currentLocation: CLLocation?
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.distanceFilter = 10
        authorizationStatus = manager.authorizationStatus
    }
    func requestWhenInUseAuthorization() {
        manager.requestWhenInUseAuthorization()
    }
    func startUpdatingLocation() {
        manager.startUpdatingLocation()
    }
    func stopUpdatingLocation() {
        manager.stopUpdatingLocation()
    }
    func requestLocation() {
        manager.requestLocation()
    }
}
extension LocationManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        DispatchQueue.main.async { [weak self] in
            self?.authorizationStatus = manager.authorizationStatus
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        DispatchQueue.main.async { [weak self] in
            self?.currentLocation = location
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    }
}
