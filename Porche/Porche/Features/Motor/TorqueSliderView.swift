import SwiftUI

// MARK: - TorqueSliderView

struct TorqueSliderView: View {
    @Binding var torqueNm: Int
    var body: some View {
        Slider(value: Binding(get: { Double(torqueNm) }, set: { torqueNm = Int($0) }), in: 0...85)
    }
}
