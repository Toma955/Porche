import Foundation
import CoreBluetooth

struct BikePeripheral: Identifiable {
    let id: UUID
    var name: String?
    var peripheral: CBPeripheral
}
