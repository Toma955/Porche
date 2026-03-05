import SwiftUI
import CoreLocation
struct ContentView: View {
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var locationManager: LocationManager
    var body: some View {
        Group {
            switch appState.onboardingStep {
            case .bikeModel:
                bikeModelScreen
            case .welcome:
                WelcomeView(onNext: { appState.onboardingStep = .permissions })
            case .permissions:
                PermissionsView(onNext: { appState.onboardingStep = .completed })
            case .completed:
                mainScreen
            }
        }
    }
    private var bikeModelScreen: some View {
        BikeModelView(rotationSpeed: 0.35) {
            appState.onboardingStep = .welcome
        }
        .ignoresSafeArea(.container)
    }
    private var mainScreen: some View {
        MainScreenRevealView(
            island: appState.island,
            isRouteActive: appState.isRouteActive,
            isFindMeMode: appState.isFindMeMode,
            onFindMe: {
                appState.isFindMeMode = true
                appState.isRouteActive = true
                appState.focusMapOnUserLocationTrigger += 1
                locationManager.requestWhenInUseAuthorization()
                locationManager.requestLocation()
                locationManager.startUpdatingLocation()
            },
            onCancelFindMe: {
                appState.isRouteActive = false
                appState.activeRoute = nil
                appState.routeProgressAlongLine = 0
            },
            onPokreniNavigaciju: { withNavigation, origin, destination in
                appState.isRouteActive = true
                if withNavigation, !origin.isEmpty, !destination.isEmpty {
                    appState.isNavigationActive = true
                    Task { @MainActor in
                        let start = await RoutePlanningService.coordinate(
                            for: origin,
                            currentLocation: locationManager.currentLocation
                        )
                        let end = await RoutePlanningService.coordinate(
                            for: destination,
                            currentLocation: locationManager.currentLocation
                        )
                        guard let s = start, let e = end else { return }
                        if let route = await RoutePlanningService.planRoute(origin: s, destination: e) {
                            appState.activeRoute = route
                            appState.routeProgressAlongLine = 0
                        }
                    }
                } else {
                    appState.isFindMeMode = true
                    appState.focusMapOnUserLocationTrigger += 1
                    locationManager.requestWhenInUseAuthorization()
                    locationManager.requestLocation()
                    locationManager.startUpdatingLocation()
                }
            },
            onExitRide: {
                appState.isRouteActive = false
                appState.activeRoute = nil
                appState.routeProgressAlongLine = 0
                appState.isNavigationActive = false
                appState.isFindMeMode = false
                appState.showMapControlsInIsland = false
                appState.mapHeading = 0
                appState.mapCameraDistance = 500
                appState.mapCenter = CLLocationCoordinate2D(latitude: 45.8129, longitude: 15.9775)
            }
        )
    }
}

private struct MainScreenRevealView: View {
    @EnvironmentObject private var appState: AppState
    @ObservedObject var island: Island
    var isRouteActive: Bool
    var isFindMeMode: Bool
    var onFindMe: () -> Void
    var onCancelFindMe: () -> Void
    var onPokreniNavigaciju: (Bool, String, String) -> Void
    var onExitRide: () -> Void

    @State private var revealed = false

    private let zoomDuration: Double = 0.65
    private let initialScale: CGFloat = 0.35

    var body: some View {
        ZStack(alignment: .bottom) {
            IslandCentralDisplayView()
                .scaleEffect(revealed ? 1 : initialScale)
                .opacity(revealed ? 1 : 0)
                .animation(.easeOut(duration: zoomDuration), value: revealed)
            if appState.island.isExpanded {
                Color.black.opacity(0.001)
                    .ignoresSafeArea()
                    .onTapGesture {
                        appState.island.requestClose = true
                    }
            }
            IslandBottomStackView(
                island: island,
                isMapVisible: isRouteActive,
                isFindMeMode: isFindMeMode,
                onFindMe: onFindMe,
                onCancelFindMe: onCancelFindMe,
                onPokreniNavigaciju: onPokreniNavigaciju,
                onExitRide: onExitRide
            )
            .scaleEffect(revealed ? 1 : initialScale, anchor: .bottom)
            .opacity(revealed ? 1 : 0)
            .animation(.easeOut(duration: zoomDuration).delay(0.08), value: revealed)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea(.all)
        .onAppear {
            withAnimation(.easeOut(duration: zoomDuration)) {
                revealed = true
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AppState())
        .environmentObject(LocationManager())
        .environmentObject(AppDebugLog.shared)
}
