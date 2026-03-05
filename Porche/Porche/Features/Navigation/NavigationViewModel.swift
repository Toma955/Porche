import Foundation
@MainActor
final class NavigationViewModel: ObservableObject {
    @Published var currentRoute: RouteModel?
    @Published var instruction: String?
}
