import SwiftUI

@main
struct PorcheApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var appState = AppState()
    @StateObject private var locationManager = LocationManager()

    init() {
        print("[Porche] App init")
        AppDebugLog.shared.log("App init")
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
                .environmentObject(locationManager)
                .environmentObject(AppDebugLog.shared)
                .onAppear { AppDebugLog.shared.log("ContentView onAppear") }
        }
    }
}
