//
//  LocationTests.swift
//  PorcheTests
//
//  Simulirana GPS ruta (npr. Trg bana Jelačića → Jarun) za unit testove.
//

import XCTest
import CoreLocation
@testable import Porche

final class LocationTests: XCTestCase {

    // MARK: - Simulirana ruta Trg bana Jelačića → Jarun

    func testSimulatedRoute_trgBanaJelacicaToJarun_hasCorrectStartAndEnd() throws {
        let route = SimulatedRoute.trgBanaJelacicaToJarun(points: 30)
        XCTAssertGreaterThanOrEqual(route.count, 2)

        let start = route.first!
        let end = route.last!

        let startCoord = start.coordinate
        XCTAssertEqual(startCoord.latitude, SimulatedRoute.trgBanaJelacica.latitude, accuracy: 0.0001)
        XCTAssertEqual(startCoord.longitude, SimulatedRoute.trgBanaJelacica.longitude, accuracy: 0.0001)

        let endCoord = end.coordinate
        XCTAssertEqual(endCoord.latitude, SimulatedRoute.jarun.latitude, accuracy: 0.0001)
        XCTAssertEqual(endCoord.longitude, SimulatedRoute.jarun.longitude, accuracy: 0.0001)
    }

    func testSimulatedRoute_timestampsIncrease() throws {
        let route = SimulatedRoute.trgBanaJelacicaToJarun(points: 10, intervalSeconds: 1.0)
        for i in 1..<route.count {
            XCTAssertGreaterThan(route[i].timestamp, route[i - 1].timestamp)
        }
    }

    func testSimulatedRoute_customPointsCount() throws {
        let route = SimulatedRoute.locations(
            from: SimulatedRoute.trgBanaJelacica,
            to: SimulatedRoute.jarun,
            numberOfPoints: 17
        )
        XCTAssertEqual(route.count, 17)
    }

    func testSimulatedRoute_approximateDistanceTrgJelacicaToJarun() throws {
        let route = SimulatedRoute.trgBanaJelacicaToJarun(points: 100)
        var totalMeters: CLLocationDistance = 0
        for i in 1..<route.count {
            totalMeters += route[i].distance(from: route[i - 1])
        }
        // Trg bana Jelačića – Jarun je reda 4–5 km
        XCTAssertGreaterThan(totalMeters, 3_000)
        XCTAssertLessThan(totalMeters, 8_000)
    }

    func testSimulatedRoute_canPretendGpsIsDriving() throws {
        // Primjer: "pravimo se da GPS vozi rutom" – iteracija kao da dolaze updatei
        let startDate = Date()
        let route = SimulatedRoute.trgBanaJelacicaToJarun(
            points: 20,
            startDate: startDate,
            intervalSeconds: 2.0,
            speedKmh: 20.0
        )

        var receivedUpdates: [CLLocation] = []
        for location in route {
            receivedUpdates.append(location)
            // Ovdje bi u pravom kodu LocationManager ili RouteTracker primao lokaciju
        }

        XCTAssertEqual(receivedUpdates.count, 20)
        XCTAssertEqual(receivedUpdates.first?.coordinate.latitude, SimulatedRoute.trgBanaJelacica.latitude, accuracy: 0.001)
        XCTAssertEqual(receivedUpdates.last?.coordinate.latitude, SimulatedRoute.jarun.latitude, accuracy: 0.001)
    }
}
