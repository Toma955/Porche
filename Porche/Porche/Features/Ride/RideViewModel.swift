import Foundation
@MainActor

// MARK: - RideViewModel

final class RideViewModel: ObservableObject {
    @Published var metrics: BikeMetrics?
    @Published var state: RideState = .idle
}
