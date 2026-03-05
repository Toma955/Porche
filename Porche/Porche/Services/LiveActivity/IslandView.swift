import SwiftUI
import ActivityKit
struct IslandView: View {
    let state: EBikeAttributes.ContentState
    var body: some View {
        Text("Ride: \(state.speed, specifier: "%.0f") km/h · \(state.batteryPercent)%")
    }
}
