import WidgetKit
import SwiftUI

/// Kad dodaš Widget Extension target u Xcodeu, premjesti ovaj file u njega i vrati @main.
struct EBikeWidgetBundle: WidgetBundle {
    var body: some Widget {
        LiveActivityWidget()
        LockScreenWidget()
    }
}
