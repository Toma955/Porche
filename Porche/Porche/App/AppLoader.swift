import SwiftUI

@MainActor
final class AppLoader {
    static func run(appState: AppState) {
        appState.loadingProgress = 0
        appState.isAppReady = false

        Task { @MainActor in
            appState.loadingProgress = 0.1
            try? await Task.sleep(nanoseconds: 100_000_000)

            await withCheckedContinuation { (cont: CheckedContinuation<Void, Never>) in
                Bike3DSceneView.preloadScene {
                    cont.resume()
                }
            }

            appState.loadingProgress = 0.85
            try? await Task.sleep(nanoseconds: 100_000_000)

            appState.loadingProgress = 1.0
        }
    }
}
