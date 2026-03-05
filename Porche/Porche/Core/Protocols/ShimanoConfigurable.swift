import Foundation
protocol ShimanoConfigurable {
    func readMotorProfile() async throws -> ShimanoMotorProfile
    func writeAssistTuning(_ tuning: AssistTuning) async throws
    func readDi2Config() async throws -> Di2Config
}
