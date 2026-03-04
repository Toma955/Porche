import Foundation

struct EBike: Identifiable, Codable {
    let id: UUID
    var name: String
    var model: String
    var batteryCapacityWh: Int
}
