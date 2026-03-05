import SwiftUI
final class AppDebugLog: ObservableObject {
    static let shared = AppDebugLog()
    @Published private(set) var lines: [String] = []
    private let maxLines = 40
    private let formatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "HH:mm:ss.SSS"
        return f
    }()
    private init() {}
    func log(_ message: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let line = "\(self.formatter.string(from: Date())) \(message)"
            self.lines.append(line)
            if self.lines.count > self.maxLines {
                self.lines.removeFirst()
            }
        }
    }
    func clear() {
        DispatchQueue.main.async { [weak self] in
            self?.lines.removeAll()
        }
    }
}
