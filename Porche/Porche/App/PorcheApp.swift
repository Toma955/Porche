import SwiftUI

@main
struct PorcheApp: App {
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
        Group {
            if appState.isAppReady {
                ContentView()
            } else {
                SplashLoadingView(progress: appState.loadingProgress) {
                    withAnimation(.easeOut(duration: 0.25)) {
                        appState.isAppReady = true
                    }
                }
                .onAppear { AppLoader.run(appState: appState) }
            }
        }
        .onChange(of: appState.isAppReady) { _, ready in
            if ready {
                WelcomeSoundService.playWelcomeSoundIfNeeded(hasPlayed: &appState.hasPlayedWelcomeSound)
            }
        }
    }
}
