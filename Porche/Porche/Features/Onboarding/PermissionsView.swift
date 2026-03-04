import SwiftUI

struct PermissionsView: View {
    var onNext: (() -> Void)?

    var body: some View {
        ZStack {
            Color(.systemBackground).ignoresSafeArea()
            VStack(spacing: AppSpacing.xl) {
                Text("Dozvole")
                    .font(AppTypography.largeTitle)
                Text("Lokacija, Bluetooth")
                    .font(AppTypography.body)
                    .foregroundStyle(.secondary)
                Spacer()
                Button("Završi") {
                    onNext?()
                }
                .buttonStyle(.borderedProminent)
                .padding(.bottom, 48)
            }
        }
    }
}
