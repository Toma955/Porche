import SwiftUI
struct NotificationToast: View {
    let notification: AppNotification
    var body: some View {
        Text(notification.title)
    }
}
