import Foundation
import MapKit
@MainActor

// MARK: - MapViewModel

final class MapViewModel: ObservableObject {
    @Published var region = MKCoordinateRegion()
    @Published var annotations: [MKAnnotation] = []
}
