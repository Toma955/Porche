import Foundation
@MainActor

// MARK: - BatteryViewModel

final class BatteryViewModel: ObservableObject {
    @Published var batteryStatus: BatteryStatus?
}
