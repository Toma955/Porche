import SwiftUI

// MARK: - NotificationToast

struct NotificationToast: View {
    let notification: AppNotification
    var body: some View {
        Text(notification.title)
    }
}
