import SwiftUI

// MARK: - MetricCardView

struct MetricCardView<Content: View>: View {
    let title: String
    @ViewBuilder let content: () -> Content
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
            content()
        }
    }
}
