import Foundation

// MARK: - ETubeService

final class ETubeService: ShimanoConfigurable {
    func readMotorProfile() async throws -> ShimanoMotorProfile {
        fatalError("TODO")
    }
    func writeAssistTuning(_ tuning: AssistTuning) async throws {}
    func readDi2Config() async throws -> Di2Config {
        fatalError("TODO")
    }
}
