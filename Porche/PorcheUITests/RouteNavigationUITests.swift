//
//  RouteNavigationUITests.swift
//  PorcheUITests
//

import XCTest

final class RouteNavigationUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testLaunchAndQuit() throws {
        let app = XCUIApplication()
        app.launch()
    }
}
