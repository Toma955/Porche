import SwiftUI

struct IslandBottomStackView: View {
    @ObservedObject var island: Island
    var isMapVisible: Bool = false
    var isFindMeMode: Bool = true
    var onFindMe: (() -> Void)? = nil
    var onCancelFindMe: (() -> Void)? = nil
    var onPokreniNavigaciju: ((Bool, String, String) -> Void)? = nil

    var body: some View {
        VStack(spacing: 0) {
            Spacer(minLength: 0)
            IslandBasicInfoView()
            IslandParametersView(isHidden: true)
            IslandDistanceView(distanceKm: 0)
            PorcheIslandView(
                island: island,
                isMapVisible: isMapVisible,
                isFindMeMode: isFindMeMode,
                onFindMe: onFindMe,
                onCancelFindMe: onCancelFindMe,
                onPokreniNavigaciju: onPokreniNavigaciju
            )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
    }
}

struct IslandDistanceView: View {
    var distanceKm: Double = 0
    var body: some View {
        HStack {
            Image(systemName: "location.fill")
                .font(.system(size: 14))
            Text(String(format: "%.1f km", distanceKm))
                .font(AppTypography.headline)
        }
        .foregroundStyle(AppColors.primary)
        .frame(maxWidth: .infinity)
        .frame(height: 44)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.tertiarySystemBackground))
        )
        .padding(.horizontal, 20)
        .padding(.bottom, 8)
    }
}

struct IslandParametersView: View {
    var isHidden: Bool = true
    var body: some View {
        if !isHidden {
            Text("Parametri")
                .font(AppTypography.caption)
                .frame(maxWidth: .infinity)
                .frame(height: 36)
                .background(Color.orange.opacity(0.2))
                .padding(.horizontal, 20)
                .padding(.bottom, 6)
        }
    }
}

struct IslandBasicInfoView: View {
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "info.circle")
                .font(.system(size: 14))
            Text("Basic info")
                .font(AppTypography.caption)
        }
        .foregroundStyle(.secondary)
        .frame(maxWidth: .infinity)
        .frame(height: 36)
        .padding(.horizontal, 20)
        .padding(.bottom, 6)
    }
}

#Preview {
    ZStack(alignment: .bottom) {
        Color(.systemBackground).ignoresSafeArea()
        IslandBottomStackView(island: Island())
    }
}
