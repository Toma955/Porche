import SwiftUI

struct EmptyStateView: View {
    var title: String
    var message: String?
    var body: some View {
        VStack {
            Text(title)
            if let message { Text(message) }
        }
    }
}
