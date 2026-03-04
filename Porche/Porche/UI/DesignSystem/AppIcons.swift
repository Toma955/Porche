import SwiftUI
import UIKit

/// Ikone iz Assets.xcassets/Icons. Ako PNG nije u bundleu, koristi se SF Symbol.
enum AppIcons {
    static let route = "Route"
    static let graph = "Graph"
    static let bike = "Bike"
    static let settings = "Settings"
    static let backArrow = "BackArrow"
    static let start = "Start"

    /// SF Symbol fallback kad asset ne postoji.
    enum Symbol {
        static let route = "map"
        static let graph = "chart.bar"
        static let bike = "bicycle"
        static let settings = "gearshape"
        static let backArrow = "chevron.left"
        static let start = "flag.fill"
    }

    /// Vraća sliku iz Assets ili SF Symbol ako asset ne postoji (nazivi točno: Route, Graph, Bike, Settings, BackArrow).
    /// Asset ikone se vraćaju kao template da primaju boju iz .foregroundStyle() (npr. bijelu na crnom islandu).
    static func image(route: String = route, symbol: String) -> Image {
        if UIImage(named: route) != nil {
            return Image(route).renderingMode(.template)
        }
        return Image(systemName: symbol)
    }

    static var imageRoute: Image { image(route: route, symbol: Symbol.route) }
    static var imageGraph: Image { image(route: graph, symbol: Symbol.graph) }
    static var imageBike: Image { image(route: bike, symbol: Symbol.bike) }
    static var imageSettings: Image { image(route: settings, symbol: Symbol.settings) }
    static var imageBackArrow: Image { image(route: backArrow, symbol: Symbol.backArrow) }
    static var imageStart: Image { image(route: start, symbol: Symbol.start) }
}

extension Image {
    static let iconRoute = AppIcons.imageRoute
    static let iconGraph = AppIcons.imageGraph
    static let iconBike = AppIcons.imageBike
    static let iconSettings = AppIcons.imageSettings
    static let iconBackArrow = AppIcons.imageBackArrow
}
