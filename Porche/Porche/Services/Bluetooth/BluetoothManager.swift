import Foundation
import CoreBluetooth
final class BluetoothManager: NSObject, ObservableObject {
    private var centralManager: CBCentralManager?
    @Published var isScanning = false
}
