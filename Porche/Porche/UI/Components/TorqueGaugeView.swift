import SwiftUI

/// Vizualni prikaz trenutnog okretnog momenta
struct TorqueGaugeView: View {
    var torqueNm: Int
    var maxNm: Int = 85
    var body: some View {
        Text("\(torqueNm) Nm")
    }
}
