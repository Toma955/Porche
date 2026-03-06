import Foundation
@MainActor

// MARK: - GarageViewModel

final class GarageViewModel: ObservableObject {
    @Published var bikes: [EBike] = []
    @Published var serviceReminders: [ServiceReminder] = []
}
