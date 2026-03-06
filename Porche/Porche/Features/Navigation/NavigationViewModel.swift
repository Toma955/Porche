import Foundation
@MainActor

// MARK: - NavigationViewModel

final class NavigationViewModel: ObservableObject {
    @Published var currentRoute: RouteModel?
    @Published var instruction: String?
}
