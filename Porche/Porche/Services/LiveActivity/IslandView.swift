import SwiftUI
import ActivityKit

/// View za Live Activity / Dynamic Island. Prima state da ne ovisi o tipu konteksta (dostupan u app i u widget extensionu).
struct IslandView: View {
    let state: EBikeAttributes.ContentState
    var body: some View {
        Text("Ride: \(state.speed, specifier: "%.0f") km/h · \(state.batteryPercent)%")
    }
}
