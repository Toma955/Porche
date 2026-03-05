import Foundation
protocol PorscheIdentifiable {
    var porscheIdentity: PorscheIdentity? { get }
    func refreshIdentity() async throws
}
