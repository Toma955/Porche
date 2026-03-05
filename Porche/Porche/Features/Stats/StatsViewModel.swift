import Foundation
@MainActor
final class StatsViewModel: ObservableObject {
    @Published var sessions: [RideSession] = []
}
