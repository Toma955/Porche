import Foundation

@MainActor
final class RoutesViewModel: ObservableObject {
    @Published var routes: [RouteModel] = []
}
