import Foundation

/// Datum, tip servisa, km do servisa
struct ServiceReminder: Identifiable {
    let id: UUID
    var dueDate: Date
    var serviceType: String
    var kmUntilService: Double
}
