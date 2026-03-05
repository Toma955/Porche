import Foundation
struct AppNotification: Identifiable {
    let id: UUID
    var title: String
    var message: String
    var level: AlertLevel
    var date: Date
}
