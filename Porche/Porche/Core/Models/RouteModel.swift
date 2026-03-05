import Foundation
import CoreLocation
struct RouteStepModel: Codable, Equatable {
    let instructionText: String
    let distanceMeters: Double
}
struct RouteModel: Identifiable, Codable, Equatable {
    let id: UUID
    var name: String
    var waypoints: [CLLocationCoordinate2D]
    var elevationProfile: [Double]
    var steps: [RouteStepModel]
    init(id: UUID = UUID(), name: String, waypoints: [CLLocationCoordinate2D], elevationProfile: [Double], steps: [RouteStepModel] = []) {
        self.id = id
        self.name = name
        self.waypoints = waypoints
        self.elevationProfile = elevationProfile
        self.steps = steps
    }
    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        id = try c.decode(UUID.self, forKey: .id)
        name = try c.decode(String.self, forKey: .name)
        waypoints = try c.decode([CLLocationCoordinate2D].self, forKey: .waypoints)
        elevationProfile = try c.decode([Double].self, forKey: .elevationProfile)
        steps = (try? c.decode([RouteStepModel].self, forKey: .steps)) ?? []
    }
    static func == (lhs: RouteModel, rhs: RouteModel) -> Bool {
        lhs.id == rhs.id
    }
}
