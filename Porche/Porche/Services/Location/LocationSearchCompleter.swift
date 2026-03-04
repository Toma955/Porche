import Foundation
import MapKit

/// Autocomplete lokacija preko MapKit; regija postavljena na Europu.
final class LocationSearchCompleter: NSObject, ObservableObject {
    private let completer = MKLocalSearchCompleter()

    @Published var results: [MKLocalSearchCompletion] = []
    @Published var queryFragment: String = "" {
        didSet {
            completer.queryFragment = queryFragment
        }
    }

    override init() {
        super.init()
        completer.delegate = self
        completer.resultTypes = [.address, .pointOfInterest]
        let europeCenter = CLLocationCoordinate2D(latitude: 50.0, longitude: 10.0)
        completer.region = MKCoordinateRegion(
            center: europeCenter,
            span: MKCoordinateSpan(latitudeDelta: 35, longitudeDelta: 40)
        )
    }

    func clear() {
        queryFragment = ""
        results = []
    }
}

extension LocationSearchCompleter: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        DispatchQueue.main.async { [weak self] in
            self?.results = completer.results
        }
    }

    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        DispatchQueue.main.async { [weak self] in
            self?.results = []
        }
    }
}
