import Foundation

/// Protocol za Porsche ID integraciju
protocol PorscheIdentifiable {
    var porscheIdentity: PorscheIdentity? { get }
    func refreshIdentity() async throws
}
