import Foundation
import CoreBluetooth

// MARK: - BluetoothManager

final class BluetoothManager: NSObject, ObservableObject {
    private var centralManager: CBCentralManager?
    @Published var isScanning = false
}
