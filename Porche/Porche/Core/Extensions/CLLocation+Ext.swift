import CoreLocation

// MARK: - CLLocation

extension CLLocation {
}
extension CLLocationCoordinate2D {
    func isEqual(to other: CLLocationCoordinate2D) -> Bool {
        latitude == other.latitude && longitude == other.longitude
    }
}
extension CLLocationCoordinate2D: Codable {
    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        let lat = try container.decode(Double.self)
        let lon = try container.decode(Double.self)
        self.init(latitude: lat, longitude: lon)
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        try container.encode(latitude)
        try container.encode(longitude)
    }
}
