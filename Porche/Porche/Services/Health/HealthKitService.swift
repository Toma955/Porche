import Foundation
import HealthKit

// MARK: - HealthKitService

final class HealthKitService {
    private let store = HKHealthStore()
    func requestAuthorization() async throws {}
    func saveWorkout(_ session: RideSession) async throws {}
}
