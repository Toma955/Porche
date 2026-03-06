import Foundation
@MainActor

// MARK: - RoutesViewModel

final class RoutesViewModel: ObservableObject {
    @Published var routes: [RouteModel] = []
}
