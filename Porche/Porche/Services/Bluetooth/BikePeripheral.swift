import Foundation
import CoreBluetooth

// MARK: - BikePeripheral

struct BikePeripheral: Identifiable {
    let id: UUID
    var name: String?
    var peripheral: CBPeripheral
}
