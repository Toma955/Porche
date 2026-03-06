import Foundation

// MARK: - Double

extension Double {
    var toKmh: Double { self }
    var toNm: Double { self }
    var toWh: Double { self }
    func formatted(style: NumberFormatter.Style = .decimal) -> String {
        NumberFormatter.localizedString(from: NSNumber(value: self), number: style)
    }
}
