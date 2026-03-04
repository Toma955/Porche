import Foundation
import MapKit

@MainActor
final class MapViewModel: ObservableObject {
    @Published var region = MKCoordinateRegion()
    @Published var annotations: [MKAnnotation] = []
}
