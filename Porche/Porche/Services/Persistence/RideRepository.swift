import Foundation

// MARK: - RideRepository

final class RideRepository {
    func save(_ session: RideSession) async throws {}
    func fetchAll() async throws -> [RideSession] { [] }
}
