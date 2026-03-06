import Foundation
@MainActor

// MARK: - PostRideViewModel

final class PostRideViewModel: ObservableObject {
    @Published var session: RideSession?
}
