import Foundation

@MainActor
final class GarageViewModel: ObservableObject {
    @Published var bikes: [EBike] = []
    @Published var serviceReminders: [ServiceReminder] = []
}
