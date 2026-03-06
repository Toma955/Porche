import WidgetKit
import SwiftUI


// MARK: - EBikeWidgetBundle

struct EBikeWidgetBundle: WidgetBundle {
    var body: some Widget {
        LiveActivityWidget()
        LockScreenWidget()
    }
}
