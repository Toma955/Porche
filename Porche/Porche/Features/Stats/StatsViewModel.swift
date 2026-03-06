import Foundation
@MainActor

// MARK: - StatsViewModel

final class StatsViewModel: ObservableObject {
    @Published var sessions: [RideSession] = []
}
