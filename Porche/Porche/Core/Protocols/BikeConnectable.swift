import Foundation

protocol BikeConnectable: AnyObject {
    var isConnected: Bool { get }
    func connect() async throws
    func disconnect()
}
