import Foundation
struct RideSession: Identifiable, Codable {
    let id: UUID
    var startDate: Date
    var endDate: Date?
    var distance: Double
    var elevationGain: Double
    var state: RideState
}
