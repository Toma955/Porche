import SwiftUI

/// Animirani prikaz Wh i postotka
struct BatteryGaugeView: View {
    var percent: Int
    var capacityWh: Int = 630
    var body: some View {
        Text("\(percent)%")
    }
}
