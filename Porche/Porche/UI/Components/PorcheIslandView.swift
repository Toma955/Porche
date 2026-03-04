import SwiftUI
import MapKit

// MARK: - Island na dnu ekrana
// Početak: samo "Porche". Prvi klik → island se širi, pojave se gumbi (Route, Graph, Bike, Settings, chevron.down).
// Klik na gumb → ispod se prikaže sadržaj tog gumba. Glavni natpis "Porche" uvijek na vrhu.

private let islandSpring = Animation.spring(response: 0.35, dampingFraction: 0.82)
private let islandSpringContent = Animation.spring(response: 0.4, dampingFraction: 0.8)

/// Island crna pozadina, natpisi bijeli.
private enum IslandColors {
    static let background = Color.black
    static let backgroundExpanded = Color.black.opacity(0.9)
    static let surface = Color(red: 0.15, green: 0.15, blue: 0.17)
    static let title = Color.white
    static let titleGradient = LinearGradient(
        colors: [Color.white, Color.white],
        startPoint: .top,
        endPoint: .bottom
    )
    static let accent = Color.white
    static let secondary = Color.white.opacity(0.8)
    static let border = Color.white.opacity(0.2)
    static let buttonBg = Color.white.opacity(0.12)
}

/// Koji je gumb u islandu odabran (sadržaj ispod).
private enum IslandSelectedButton: String, CaseIterable {
    case route
    case graph
    case bike
    case settings
}

struct PorcheIslandView: View {
    @ObservedObject var island: Island
    var accentColor: Color = IslandColors.accent
    var isMapVisible: Bool = false
    var isFindMeMode: Bool = true
    var onFindMe: (() -> Void)? = nil
    var onCancelFindMe: (() -> Void)? = nil
    var onPokreniNavigaciju: ((Bool, String, String) -> Void)? = nil

    private let collapsedHeight: CGFloat = 44
    private let iconSizeExpanded: CGFloat = 62
    /// Kad je proširen, samo red ikona (bez natpisa) – visina tog dijela.
    private var expandedPillSectionHeight: CGFloat { iconSizeExpanded + 28 }
    private let horizontalPadding: CGFloat = 20
    /// Veći radijus + continuous stil da prati zaobljenost donjeg ruba ekrana.
    private let cornerRadius: CGFloat = 40

    @State private var showButtonsContent = false
    private let contentDelay: Double = 0.12
    /// Klik na koji gumb – ispod se prikaže njegov sadržaj.
    @State private var selectedButton: IslandSelectedButton?
    /// Destinacije za rutu (kao na Google Maps: od točke A do točke B).
    @State private var routeOrigin: String = ""
    @State private var routeDestination: String = ""
    @StateObject private var locationCompleter = LocationSearchCompleter()
    @FocusState private var focusedDestinationField: DestinationField?

    private enum DestinationField {
        case origin, destination
    }

    private var isExpanded: Bool { island.state != .compact }
    private var hasRouteDestinations: Bool { !routeOrigin.isEmpty || !routeDestination.isEmpty }

    var body: some View {
        VStack(spacing: 0) {
            Spacer(minLength: 0)
            VStack(spacing: 0) {
                if isExpanded {
                    expandedContent
                        .transition(.asymmetric(
                            insertion: .move(edge: .bottom).combined(with: .opacity),
                            removal: .move(edge: .bottom).combined(with: .opacity)
                        ))
                }
                pillBar
            }
            .frame(width: islandWidth)
            .frame(maxHeight: expandedMaxHeight)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(isExpanded ? IslandColors.backgroundExpanded : IslandColors.background)
                    .overlay(
                        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                            .stroke(IslandColors.border, lineWidth: 1)
                    )
            )
            .shadow(color: .black.opacity(0.4), radius: 16, x: 0, y: 6)
            .animation(islandSpring, value: island.state)
            .padding(.horizontal, horizontalPadding)
            .padding(.bottom, 20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .onChange(of: island.state) { _, newState in
            if newState != .compact {
                DispatchQueue.main.asyncAfter(deadline: .now() + contentDelay) {
                    if island.state != .compact { showButtonsContent = true }
                }
            } else {
                showButtonsContent = false
                selectedButton = nil
            }
        }
        .onChange(of: island.requestClose) { _, requested in
            guard requested else { return }
            withAnimation(islandSpring) {
                showButtonsContent = false
                selectedButton = nil
                island.state = .compact
            }
            island.requestClose = false
        }
    }

    private var islandWidth: CGFloat {
        switch island.state {
        case .compact: return 160
        case .actions: return 400
        case .fullStats: return UIScreen.main.bounds.width - horizontalPadding * 2
        }
    }

    private var expandedMaxHeight: CGFloat? {
        switch island.state {
        case .compact: return collapsedHeight
        case .actions: return selectedButton != nil ? (expandedPillSectionHeight + 220) : expandedPillSectionHeight
        case .fullStats: return UIScreen.main.bounds.height * 0.85
        }
    }

    /// Compact: samo "Porche". Kad je proširen: samo red gumba (bez natpisa), veće ikone, na sredini.
    private var pillBar: some View {
        Group {
            if isExpanded {
                islandIconRow
            } else {
                Button {
                    withAnimation(islandSpring) { island.state = .actions }
                } label: {
                    Text(island.title)
                        .font(AppTypography.headline)
                        .foregroundStyle(IslandColors.titleGradient)
                        .frame(maxWidth: .infinity)
                        .frame(height: collapsedHeight)
                        .padding(.horizontal, 20)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.vertical, isExpanded ? 14 : 0)
        .padding(.horizontal, isExpanded ? iconRowGap : 20)
    }

    /// Jedan red: Route, Graph, strelica, Bike, Settings. Isti razmak između gumba i do rubova.
    private let iconRowGap: CGFloat = 12
    private var islandIconRow: some View {
        HStack(spacing: iconRowGap) {
            IslandRoundIconButton(image: AppIcons.imageRoute, size: iconSizeExpanded, isSelected: selectedButton == .route) {
                withAnimation(islandSpring) { selectedButton = selectedButton == .route ? nil : .route }
            }
            IslandRoundIconButton(image: AppIcons.imageGraph, size: iconSizeExpanded, isSelected: selectedButton == .graph) {
                withAnimation(islandSpring) { selectedButton = selectedButton == .graph ? nil : .graph }
            }
            IslandRoundIconButton(image: Image(systemName: "chevron.down"), size: iconSizeExpanded, isSelected: false) {
                withAnimation(islandSpring) {
                    selectedButton = nil
                    island.state = .compact
                }
            }
            IslandRoundIconButton(image: AppIcons.imageBike, size: iconSizeExpanded, isSelected: selectedButton == .bike) {
                withAnimation(islandSpring) { selectedButton = selectedButton == .bike ? nil : .bike }
            }
            IslandRoundIconButton(image: AppIcons.imageSettings, size: iconSizeExpanded, isSelected: selectedButton == .settings) {
                withAnimation(islandSpring) { selectedButton = selectedButton == .settings ? nil : .settings }
            }
        }
        .padding(.horizontal, iconRowGap)
        .frame(maxWidth: .infinity)
        .opacity(showButtonsContent ? 1 : 0)
    }

    @ViewBuilder
    private var expandedContent: some View {
        Group {
            if let selected = selectedButton, showButtonsContent {
                buttonContent(selected)
                    .transition(.opacity.combined(with: .move(edge: .bottom)))
                    .frame(maxWidth: .infinity)
                    .frame(height: expandedContentHeight)
            }
        }
        .animation(islandSpringContent, value: selectedButton)
        .animation(islandSpringContent, value: showButtonsContent)
    }

    private var expandedContentHeight: CGFloat {
        switch island.state {
        case .compact: return 0
        case .actions: return 220
        case .fullStats: return (UIScreen.main.bounds.height * 0.85) - expandedPillSectionHeight - 24
        }
    }

    @ViewBuilder
    private func buttonContent(_ button: IslandSelectedButton) -> some View {
        switch button {
        case .route:
            routeContent
        case .graph:
            graphContent
        case .bike:
            bikeContent
        case .settings:
            settingsContent
        }
    }

    private var routeContent: some View {
        VStack(alignment: .center, spacing: 14) {
            if isMapVisible {
                Button { onCancelFindMe?() } label: {
                    Text("Poništi")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(Color.red)
                }
                .buttonStyle(.plain)
                .frame(maxWidth: .infinity)
            }
            destinationRows
                .frame(maxWidth: .infinity)
            Button { onPokreniNavigaciju?(hasRouteDestinations, routeOrigin, routeDestination) } label: {
                HStack(spacing: 6) {
                    if hasRouteDestinations {
                        AppIcons.imageStart
                            .font(.system(size: 14))
                    }
                    Text(hasRouteDestinations ? "Pokreni navigaciju" : "Pokreni bez navigacije")
                        .font(.system(size: 14, weight: .semibold))
                }
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(Capsule().fill(Color.green))
            }
            .buttonStyle(.plain)
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .center)
    }

    /// Redovi za polazište (A) i odredište (B) – TextField + autocomplete europskih lokacija.
    private var destinationRows: some View {
        VStack(spacing: 0) {
            destinationRow(
                icon: "circle.fill",
                iconColor: Color.green,
                label: "Polazište",
                text: $routeOrigin,
                placeholder: "Adresa ili trenutna lokacija",
                field: .origin,
                onUseMyLocation: { routeOrigin = "Trenutna lokacija" }
            )
            Rectangle()
                .fill(IslandColors.border)
                .frame(height: 1)
                .padding(.leading, 32)
            destinationRow(
                icon: "circle.fill",
                iconColor: Color.red,
                label: "Odredište",
                text: $routeDestination,
                placeholder: "Unesi adresu odredišta",
                field: .destination,
                onUseMyLocation: { routeDestination = "Trenutna lokacija" }
            )
            if focusedDestinationField != nil, !locationCompleter.results.isEmpty {
                Divider()
                    .background(IslandColors.border)
                    .padding(.leading, 32)
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 0) {
                        ForEach(Array(locationCompleter.results.enumerated()), id: \.offset) { _, completion in
                            Button {
                                applySuggestion(completion)
                            } label: {
                                HStack(alignment: .center, spacing: 12) {
                                    Image(systemName: "mappin.circle.fill")
                                        .font(.system(size: 14))
                                        .foregroundStyle(IslandColors.secondary)
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(completion.title)
                                            .font(AppTypography.caption)
                                            .foregroundStyle(IslandColors.title)
                                            .lineLimit(2)
                                            .multilineTextAlignment(.leading)
                                        if !completion.subtitle.isEmpty {
                                            Text(completion.subtitle)
                                                .font(AppTypography.caption2)
                                                .foregroundStyle(IslandColors.secondary)
                                                .lineLimit(2)
                                                .multilineTextAlignment(.leading)
                                        }
                                    }
                                    Spacer(minLength: 0)
                                }
                                .padding(.horizontal, 14)
                                .padding(.vertical, 14)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .contentShape(Rectangle())
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .frame(maxHeight: 260)
            }
        }
        .background(RoundedRectangle(cornerRadius: 12, style: .continuous).fill(IslandColors.surface))
        .overlay(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .stroke(IslandColors.border, lineWidth: 1)
        )
        .onChange(of: focusedDestinationField) { _, newValue in
            switch newValue {
            case .origin:
                locationCompleter.queryFragment = routeOrigin
            case .destination:
                locationCompleter.queryFragment = routeDestination
            case nil:
                locationCompleter.clear()
            }
        }
        .onChange(of: routeOrigin) { _, _ in
            if focusedDestinationField == .origin { locationCompleter.queryFragment = routeOrigin }
        }
        .onChange(of: routeDestination) { _, _ in
            if focusedDestinationField == .destination { locationCompleter.queryFragment = routeDestination }
        }
    }

    private func applySuggestion(_ completion: MKLocalSearchCompletion) {
        let text = [completion.title, completion.subtitle].filter { !$0.isEmpty }.joined(separator: ", ")
        if focusedDestinationField == .origin {
            routeOrigin = text
        } else {
            routeDestination = text
        }
        focusedDestinationField = nil
        locationCompleter.clear()
    }

    private func destinationRow(
        icon: String,
        iconColor: Color,
        label: String,
        text: Binding<String>,
        placeholder: String,
        field: DestinationField,
        onUseMyLocation: @escaping () -> Void
    ) -> some View {
        HStack(alignment: .center, spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 10))
                .foregroundStyle(iconColor)
            VStack(alignment: .leading, spacing: 2) {
                Text(label)
                    .font(AppTypography.caption2)
                    .foregroundStyle(IslandColors.secondary)
                TextField(placeholder, text: text)
                    .font(AppTypography.caption)
                    .foregroundStyle(IslandColors.title)
                    .textContentType(.fullStreetAddress)
                    .submitLabel(.done)
                    .focused($focusedDestinationField, equals: field)
            }
            Spacer(minLength: 0)
            Button(action: onUseMyLocation) {
                Image(systemName: "location.fill")
                    .font(.system(size: 16))
                    .foregroundStyle(IslandColors.accent)
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
    }

    private var graphContent: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Statistika")
                .font(AppTypography.headline)
                .foregroundStyle(IslandColors.titleGradient)
            Text("Grafovi i statistika vožnje.")
                .font(AppTypography.caption)
                .foregroundStyle(IslandColors.secondary)
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .topLeading)
    }

    private var bikeContent: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Bicikl")
                .font(AppTypography.headline)
                .foregroundStyle(IslandColors.titleGradient)
            Text("Status bicikla, baterija, motor.")
                .font(AppTypography.caption)
                .foregroundStyle(IslandColors.secondary)
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .topLeading)
    }

    private var settingsContent: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Postavke")
                .font(AppTypography.headline)
                .foregroundStyle(IslandColors.titleGradient)
            Text("Postavke aplikacije i uređaja.")
                .font(AppTypography.caption)
                .foregroundStyle(IslandColors.secondary)
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .topLeading)
    }

}

/// Okrugli gumb za red ikona u islandu (Route, Graph, chevron.down, Bike, Settings).
private struct IslandRoundIconButton: View {
    let image: Image
    var size: CGFloat = 40
    var isSelected: Bool = false
    let action: () -> Void

    private var iconSize: CGFloat { size * 0.55 }

    var body: some View {
        Button(action: action) {
            image
                .resizable()
                .scaledToFit()
                .frame(width: iconSize, height: iconSize)
                .foregroundStyle(IslandColors.accent)
                .frame(width: size, height: size)
                .background(Circle().fill(IslandColors.buttonBg))
                .overlay(
                    Circle()
                        .stroke(IslandColors.accent.opacity(isSelected ? 0.8 : 0), lineWidth: 2)
                )
        }
        .buttonStyle(.plain)
    }
}

private struct IslandActionButton: View {
    let icon: String
    let label: String
    var subtitle: String?
    let accentColor: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.system(size: 18))
                Text(label)
                    .font(AppTypography.caption2)
                if let sub = subtitle, !sub.isEmpty {
                    Text(sub)
                        .font(AppTypography.caption2)
                        .foregroundStyle(IslandColors.secondary)
                        .lineLimit(1)
                }
            }
            .foregroundStyle(accentColor)
            .frame(minWidth: 56)
            .padding(.vertical, 10)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(accentColor.opacity(0.08))
            )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    ZStack(alignment: .bottom) {
        Color.gray.opacity(0.3).ignoresSafeArea()
        PorcheIslandView(island: Island())
    }
}
