import SwiftUI
struct BatteryGaugeView: View {
    var percent: Int
    var capacityWh: Int = 630
    var body: some View {
        Text("\(percent)%")
    }
}
