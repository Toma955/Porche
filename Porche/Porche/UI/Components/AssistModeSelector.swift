import SwiftUI

// MARK: - AssistModeSelector

struct AssistModeSelector: View {
    @Binding var selectedMode: AssistMode
    var body: some View {
        Picker("Mode", selection: $selectedMode) {
            ForEach(AssistMode.allCases, id: \.self) { mode in
                Text(mode.displayTitle).tag(mode)
            }
        }
        .pickerStyle(.segmented)
    }
}
