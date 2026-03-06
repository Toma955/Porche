import Foundation

// MARK: - RouteRepository

final class RouteRepository {
    func save(_ route: RouteModel) async throws {}
    func fetchAll() async throws -> [RouteModel] { [] }
}
