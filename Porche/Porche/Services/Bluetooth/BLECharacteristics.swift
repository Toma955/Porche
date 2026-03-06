import Foundation
import CoreBluetooth

// MARK: - BLECharacteristics

enum BLECharacteristics {
    static let speed = CBUUID(string: "00002A5B-0000-1000-8000-00805F9B34FB")
    static let cadence = CBUUID(string: "00002A5C-0000-1000-8000-00805F9B34FB")
    static let battery = CBUUID(string: "00002A19-0000-1000-8000-00805F9B34FB")
    static let motor = CBUUID(string: "00002A6E-0000-1000-8000-00805F9B34FB")
    static let di2 = CBUUID(string: "00002A6F-0000-1000-8000-00805F9B34FB")
}
