//
//  PorcheUITests.swift
//  PorcheUITests
//
//  Created by Toma Babić on 04.03.2026..
//

import XCTest

final class PorcheUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testLaunchAndQuit() throws {
        let app = XCUIApplication()
        app.launch()
    }
}
