//
//  PorcheUITestsLaunchTests.swift
//  PorcheUITests
//
//  Created by Toma Babić on 04.03.2026..
//

import XCTest

final class PorcheUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()
    }
}
