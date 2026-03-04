import Foundation

@MainActor
final class PostRideViewModel: ObservableObject {
    @Published var session: RideSession?
}
