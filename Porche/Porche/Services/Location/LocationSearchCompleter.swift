import Foundation
import MapKit

// MARK: - LocationSearchCompleter

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
        completer.region = LocationConstants.croatiaRegion
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
