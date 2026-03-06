import Foundation

// MARK: - SettingsStore

final class SettingsStore: ObservableObject {
    @Published var unitSystem: UnitSystem = .metric
    @Published var mapStyle: MapTerrainStyle = .standard
}
