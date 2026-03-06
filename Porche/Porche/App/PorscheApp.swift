import SwiftUI

// MARK: - PorscheApp

@main
struct PorscheApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var appState = AppState()
    @StateObject private var locationManager = LocationManager()

    init() {}

    var body: some Scene {
        WindowGroup {
            RootView(appState: appState)
                .environmentObject(appState)
                .environmentObject(locationManager)
                .environmentObject(AppDebugLog.shared)
        }
    }
}

private struct RootView: View {
    @ObservedObject var appState: AppState

    var body: some View {
        ContentView()
            .onAppear {
                if !appState.isAppReady { AppLoader.run(appState: appState) }
            }
    }
}
