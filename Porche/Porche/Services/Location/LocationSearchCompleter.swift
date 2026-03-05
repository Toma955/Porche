import Foundation
import MapKit

/// Regija za pretragu hrvatskih lokacija (centar Hrvatske + susjedi).
private let croatiaRegion: MKCoordinateRegion = {
    let center = CLLocationCoordinate2D(latitude: 45.1, longitude: 15.2)
    return MKCoordinateRegion(
        center: center,
        span: MKCoordinateSpan(latitudeDelta: 6, longitudeDelta: 8)
    )
}()

/// Autocomplete lokacija preko MapKit; regija postavljena na Hrvatsku.
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
        completer.region = croatiaRegion
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
