import Foundation
@MainActor
final class MotorTuningViewModel: ObservableObject {
    @Published var tuning: AssistTuning = AssistTuning(maxTorqueNm: 85, assistCharacter: 0.5, assistStart: 0.5)
    @Published var di2Config: Di2Config = Di2Config(shiftMode: .freeShift, autoShiftSensitivity: 5)
}
