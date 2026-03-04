import Foundation

protocol Persistable where Self: Codable {
    static var storageKey: String { get }
}
