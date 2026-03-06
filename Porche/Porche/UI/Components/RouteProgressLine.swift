import SwiftUI

// MARK: - RouteProgressLine

struct RouteProgressLine: View {
    var progress: Double
    var body: some View {
        ProgressView(value: progress)
    }
}
