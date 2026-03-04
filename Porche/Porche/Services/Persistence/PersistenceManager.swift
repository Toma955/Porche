import Foundation

final class PersistenceManager {
    func save<T: Encodable>(_ value: T, key: String) throws {}
    func load<T: Decodable>(key: String) throws -> T? { nil }
}
