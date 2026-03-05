import SwiftUI
struct DebugConsoleView: View {
    @EnvironmentObject var log: AppDebugLog
    @State private var isExpanded = true
    @State private var copiedFeedback = false
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("Konzola (\(log.lines.count))")
                    .font(.caption.weight(.semibold))
                Spacer()
                Button(copiedFeedback ? "Kopirano!" : "Kopiraj") {
                    let text = log.lines.joined(separator: "\n")
                    UIPasteboard.general.string = text
                    copiedFeedback = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        copiedFeedback = false
                    }
                }
                .font(.caption2)
                Button("Clear") {
                    log.clear()
                }
                .font(.caption2)
                Button(isExpanded ? "▼" : "▶") {
                    isExpanded.toggle()
                }
                .font(.caption2)
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 6)
            .background(Color.orange.opacity(0.3))
            if isExpanded {
                ScrollViewReader { proxy in
                    ScrollView(.vertical, showsIndicators: true) {
                        LazyVStack(alignment: .leading, spacing: 2) {
                            ForEach(Array(log.lines.enumerated()), id: \.offset) { _, line in
                                Text(line)
                                    .font(.system(size: 10, design: .monospaced))
                                    .foregroundStyle(.primary)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .padding(6)
                    }
                    .frame(maxHeight: 180)
                    .onChange(of: log.lines.count) { _, _ in
                        if let last = log.lines.indices.last {
                            proxy.scrollTo(last, anchor: .bottom)
                        }
                    }
                }
                .background(Color(UIColor.systemBackground))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(UIColor.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.orange, lineWidth: 2)
        )
        .padding(8)
        .onAppear { log.log("Konzola spremna") }
    }
}
#Preview {
    VStack {
        DebugConsoleView()
            .environmentObject(AppDebugLog.shared)
        Spacer()
    }
}
