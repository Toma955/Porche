import Foundation
@MainActor
final class BatteryViewModel: ObservableObject {
    @Published var batteryStatus: BatteryStatus?
}
