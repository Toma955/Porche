import SwiftUI
import MapKit
import CoreLocation

private let trgBanaJelacica = CLLocationCoordinate2D(latitude: 45.8129, longitude: 15.9775)
private let defaultCameraDistance: CGFloat = 650
private let userLocationCameraDistance: CGFloat = 500
private let mapBikeWidth: CGFloat = 212
private let mapBikeHeight: CGFloat = 192
private let normalBikeWidth: CGFloat = 220
private let normalBikeHeight: CGFloat = 200
private let routeTransitionDuration: Double = 0.28
private let bikeSpring = Animation.spring(response: 0.32, dampingFraction: 0.84)

struct IslandCentralDisplayView: View {
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var locationManager: LocationManager
    @State private var isBikeSceneReady = false
    @State private var cameraPosition: MapCameraPosition = .camera(
        MapCamera(
            centerCoordinate: trgBanaJelacica,
            distance: defaultCameraDistance,
            heading: 0,
            pitch: 60
        )
    )

    var body: some View {
        ZStack {
            if appState.isRouteActive {
                Map(position: $cameraPosition) {
                    if let route = appState.activeRoute, !route.waypoints.isEmpty {
                        MapPolyline(coordinates: route.waypoints)
                            .stroke(.blue, lineWidth: 5)
                    }
                }
                .mapStyle(.standard(elevation: .realistic))
                .transition(.opacity.animation(.easeInOut(duration: routeTransitionDuration)))
            } else {
                Color.white
                    .transition(.opacity.animation(.easeInOut(duration: routeTransitionDuration)))
            }

            VStack(spacing: 0) {
                if appState.isRouteActive {
                    Spacer(minLength: 0)
                    bikeView(width: mapBikeWidth, height: mapBikeHeight, findMeMode: true)
                    Spacer(minLength: 0)
                } else {
                    Spacer(minLength: 16)
                    bikeView(width: normalBikeWidth, height: normalBikeHeight, findMeMode: false)
                    Spacer(minLength: 220)
                }
            }
            .animation(bikeSpring, value: appState.isRouteActive)
        }
        .animation(.easeInOut(duration: routeTransitionDuration), value: appState.isRouteActive)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.primary.opacity(0.25), lineWidth: 1)
        )
        .onChange(of: appState.focusMapOnUserLocationTrigger) { _, _ in
            requestFreshLocationForFindMe()
        }
        .onChange(of: locationManager.currentLocation) { _, newLocation in
            if appState.focusMapOnUserLocationTrigger > 0, let loc = newLocation, isLocationValidForMap(loc) {
                centerCamera(on: loc.coordinate)
                locationManager.stopUpdatingLocation()
            }
        }
        .onChange(of: appState.activeRoute) { _, newRoute in
            if let route = newRoute, !route.waypoints.isEmpty {
                fitCameraToRoute(route.waypoints)
            }
        }
    }

    private func fitCameraToRoute(_ waypoints: [CLLocationCoordinate2D]) {
        guard waypoints.count >= 2 else { return }
        let lats = waypoints.map(\.latitude)
        let lons = waypoints.map(\.longitude)
        let minLat = lats.min() ?? 0, maxLat = lats.max() ?? 0
        let minLon = lons.min() ?? 0, maxLon = lons.max() ?? 0
        let center = CLLocationCoordinate2D(
            latitude: (minLat + maxLat) / 2,
            longitude: (minLon + maxLon) / 2
        )
        let span = max(maxLat - minLat, maxLon - minLon) * 1.4
        let region = MKCoordinateRegion(
            center: center,
            span: MKCoordinateSpan(latitudeDelta: max(span, 0.02), longitudeDelta: max(span, 0.02))
        )
        withAnimation(.easeInOut(duration: 0.4)) {
            cameraPosition = .region(region)
        }
    }

    @ViewBuilder
    private func bikeView(width: CGFloat, height: CGFloat, findMeMode: Bool) -> some View {
        ZStack {
            Bike3DSceneView(rotationSpeed: findMeMode ? 0 : 0.35, isFindMeMode: findMeMode) {
                isBikeSceneReady = true
            }
            .frame(width: width, height: height)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            if !isBikeSceneReady {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(.systemBackground).opacity(0.9))
                    .overlay(ProgressView())
                    .frame(width: width, height: height)
            }
        }
        .transition(.opacity.animation(bikeSpring))
    }

    /// Traži novu lokaciju; ne koristi cache – centriranje tek kad stigne nova u onChange(currentLocation).
    private func requestFreshLocationForFindMe() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        locationManager.startUpdatingLocation()
    }

    private func isLocationValidForMap(_ location: CLLocation) -> Bool {
        let coord = location.coordinate
        guard CLLocationCoordinate2DIsValid(coord) else { return false }
        guard abs(coord.latitude) > 0.0001, abs(coord.longitude) > 0.0001 else { return false }
        return true
    }

    private func centerCamera(on coordinate: CLLocationCoordinate2D) {
        withAnimation(.easeInOut(duration: 0.35)) {
            cameraPosition = .camera(
                MapCamera(
                    centerCoordinate: coordinate,
                    distance: userLocationCameraDistance,
                    heading: 0,
                    pitch: 60
                )
            )
        }
    }
}

#Preview {
    IslandCentralDisplayView()
        .environmentObject(AppState())
}
