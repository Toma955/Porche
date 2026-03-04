import SwiftUI
import CoreLocation

@MainActor
final class AppState: ObservableObject {
    var onboardingStep: OnboardingStep = .completed
    let island = Island()
    /// Kad true, u centralnom prikazu se pokazuje mapa + bicikl (ptičja perspektiva).
    @Published var isRouteActive: Bool = false
    /// true = prikaz otvoren preko "Nađi me" (crveni Poništi), false = preko "Početak" (zeleni Pokreni navigaciju).
    var isFindMeMode: Bool = true
    /// Kad se poveća, centralni prikaz (mapa) centrira na trenutnu lokaciju korisnika.
    var focusMapOnUserLocationTrigger: Int = 0
    /// Kad true, navigacija je pokrenuta (ruta aktivna).
    var isNavigationActive: Bool = false
    /// Ruta za navigaciju (poligona za prikaz na karti).
    @Published var activeRoute: RouteModel?
}

enum OnboardingStep {
    case bikeModel
    case welcome
    case permissions
    case completed
}
