import Foundation
import CoreLocation

protocol RouteNavigable {
    var currentRoute: RouteModel? { get }
    func startNavigation(route: RouteModel) async
    func stopNavigation()
}
