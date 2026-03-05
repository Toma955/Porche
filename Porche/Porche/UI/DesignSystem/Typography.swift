import SwiftUI
import UIKit
enum AppTypography {
    private static let archivoName = "Archivo"
    private static let isArchivoAvailable: Bool = {
        let available = UIFont(name: archivoName, size: 17) != nil
            || UIFont(name: "Archivo-Regular", size: 17) != nil
        return available
    }()
    private static func font(size: CGFloat, weight: Font.Weight) -> Font {
        if isArchivoAvailable {
            return Font.custom(archivoName, size: size).weight(weight)
        }
        return Font.system(size: size, weight: weight)
    }
    static var largeTitle: Font { font(size: 34, weight: .regular) }
    static var title: Font { font(size: 28, weight: .regular) }
    static var title2: Font { font(size: 22, weight: .regular) }
    static var title3: Font { font(size: 20, weight: .regular) }
    static var headline: Font { font(size: 17, weight: .semibold) }
    static var body: Font { font(size: 17, weight: .regular) }
    static var callout: Font { font(size: 16, weight: .regular) }
    static var subheadline: Font { font(size: 15, weight: .regular) }
    static var footnote: Font { font(size: 13, weight: .regular) }
    static var caption: Font { font(size: 12, weight: .regular) }
    static var caption2: Font { font(size: 11, weight: .regular) }
    static func custom(size: CGFloat, weight: Font.Weight = .regular) -> Font {
        font(size: size, weight: weight)
    }
}
