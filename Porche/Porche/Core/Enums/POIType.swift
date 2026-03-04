import Foundation

/// cafe, service, charger, park, water
enum POIType: String, Codable, CaseIterable {
    case cafe
    case service
    case charger
    case park
    case water
}
