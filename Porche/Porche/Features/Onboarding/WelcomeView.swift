import SwiftUI

// MARK: - WelcomeView

struct WelcomeView: View {
    var onNext: (() -> Void)?
    var body: some View {
        ZStack {
            Color(.systemBackground).ignoresSafeArea()
            VStack(spacing: AppSpacing.xl) {
                Text("Dobrodošli")
                    .font(AppTypography.largeTitle)
                Spacer()
                Button("Nastavi") {
                    onNext?()
                }
                .buttonStyle(.borderedProminent)
                .padding(.bottom, 48)
            }
        }
    }
}
