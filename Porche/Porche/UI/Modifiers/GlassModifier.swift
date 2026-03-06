import SwiftUI

// MARK: - GlassModifier

struct GlassModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(.ultraThinMaterial)
    }
}
