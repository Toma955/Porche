import Foundation

/// Čitanje/pisanje torque, assist, start params
final class MotorTuningService {
    func readTuning() async throws -> AssistTuning { fatalError("TODO") }
    func writeTuning(_ tuning: AssistTuning) async throws {}
}
