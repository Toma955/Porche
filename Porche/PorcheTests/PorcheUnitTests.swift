import XCTest
import CoreLocation
@testable import Porche

final class PorcheUnitTests: XCTestCase {

    func testRideStatisticsDefaults() {
        let stats = RideStatistics()
        XCTAssertEqual(stats.live.speedKmh, 0)
        XCTAssertEqual(stats.live.batteryPercent, 0)
        XCTAssertEqual(stats.live.rangeKm, 0)
        XCTAssertEqual(stats.live.assistModeTitle, "")
        XCTAssertEqual(stats.telemetry.cadenceRpm, 0)
        XCTAssertEqual(stats.diagnostics.batterySohPercent, 0)
    }

    func testRideStatisticsPlaceholder() {
        let stats = RideStatistics.placeholder
        XCTAssertEqual(stats.live.batteryPercent, 87)
        XCTAssertEqual(stats.live.rangeKm, 42)
        XCTAssertEqual(stats.live.assistModeTitle, "Eco")
        XCTAssertEqual(stats.live.gearCurrent, 7)
        XCTAssertEqual(stats.live.gearMax, 12)
        XCTAssertEqual(stats.telemetry.cadenceRpm, 72)
        XCTAssertEqual(stats.telemetry.motorPowerW, 120)
        XCTAssertEqual(stats.track.altitudeM, 312)
        XCTAssertEqual(stats.diagnostics.batterySohPercent, 98)
        XCTAssertEqual(stats.history.caloriesBurned, 420)
    }

    func testBatteryStatus() {
        let bat = BatteryStatus(capacityWh: 500, percent: 100, estimatedRangeKm: 99)
        XCTAssertEqual(bat.capacityWh, 500)
        XCTAssertEqual(bat.percent, 100)
        XCTAssertEqual(bat.estimatedRangeKm, 99)
    }

    func testAssistModeDisplayTitle() {
        XCTAssertEqual(AssistMode.eco.displayTitle, "ECO")
        XCTAssertEqual(AssistMode.off.displayTitle, "OFF")
        XCTAssertEqual(AssistMode.turboBoost.displayTitle, "TURBO / BOOST")
    }

    func testRouteStepModel() {
        let step = RouteStepModel(instructionText: "Skrenite lijevo", distanceMeters: 450)
        XCTAssertEqual(step.instructionText, "Skrenite lijevo")
        XCTAssertEqual(step.distanceMeters, 450)
    }

    func testRouteModelInit() {
        let id = UUID()
        let waypoints: [CLLocationCoordinate2D] = [
            .init(latitude: 45.81, longitude: 15.97),
            .init(latitude: 45.78, longitude: 15.92)
        ]
        let steps = [
            RouteStepModel(instructionText: "Krenite", distanceMeters: 1000)
        ]
        let route = RouteModel(id: id, name: "Test", waypoints: waypoints, elevationProfile: [0, 10], steps: steps)
        XCTAssertEqual(route.id, id)
        XCTAssertEqual(route.name, "Test")
        XCTAssertEqual(route.waypoints.count, 2)
        XCTAssertEqual(route.steps.count, 1)
        XCTAssertEqual(route.steps[0].instructionText, "Krenite")
    }

    func testRouteModelEquality() {
        let id = UUID()
        let waypoints: [CLLocationCoordinate2D] = [.init(latitude: 0, longitude: 0)]
        let a = RouteModel(id: id, name: "A", waypoints: waypoints, elevationProfile: [], steps: [])
        let b = RouteModel(id: id, name: "B", waypoints: waypoints, elevationProfile: [1], steps: [])
        XCTAssertEqual(a, b)
    }

    @MainActor
    func testDemoRideSimulationRoute() async {
        let route = DemoRideSimulation.demoRoute
        XCTAssertFalse(route.waypoints.isEmpty)
        XCTAssertFalse(route.steps.isEmpty)
        XCTAssertEqual(route.name, DemoRideSimulation.routeName)
    }
}
