import XCTest

final class RideViewUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testLaunchAndQuit() throws {
        let app = XCUIApplication()
        app.launch()
    }
}
