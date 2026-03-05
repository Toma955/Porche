//
//  RouteNavigationUITests.swift
//  PorcheUITests
//
//  Unit/UI test: podići app, unijeti polazište "Trg bana Jelačića" i odredište "Jarun jezerok",
//  pokrenuti navigaciju i provjeriti da se prikaže put (ruta).
//

import XCTest

final class RouteNavigationUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    /// Podigne app, unese polazište i odredište, pokrene navigaciju i provjeri da se put prikaže.
    @MainActor
    func testRouteFromTrgBanaJelacicaToJarunJezerok() throws {
        let app = XCUIApplication()
        app.launch()

        // Čekaj glavni ekran (island s naslovom "Porche Ebike" ili sl.)
        let islandTitle = app.staticTexts["Porche Ebike"]
        XCTAssertTrue(islandTitle.waitForExistence(timeout: 5), "Glavni ekran nije vidljiv")

        // Proširi island: tap na naslov/pill da se otvore gumbi
        islandTitle.tap()
        sleep(1)

        // Otvori Ruta: tap na gumb Route (ikona rute)
        let routeButton = app.buttons["islandButtonRoute"]
        XCTAssertTrue(routeButton.waitForExistence(timeout: 3), "Gumb Ruta nije pronađen")
        routeButton.tap()
        sleep(1)

        // Unesi polazište: Trg bana Jelačića
        let originField = app.textFields["routeOriginField"]
        XCTAssertTrue(originField.waitForExistence(timeout: 3), "Polje Polazište nije pronađeno")
        originField.tap()
        originField.typeText("Trg bana Jelačića")
        sleep(1)

        // Unesi odredište: Jarun jezerok
        let destinationField = app.textFields["routeDestinationField"]
        XCTAssertTrue(destinationField.waitForExistence(timeout: 2), "Polje Odredište nije pronađeno")
        destinationField.tap()
        destinationField.typeText("Jarun jezerok")
        sleep(1)

        // Pokreni navigaciju
        let pokreniButton = app.buttons["pokreniNavigacijuButton"]
        XCTAssertTrue(pokreniButton.waitForExistence(timeout: 2), "Gumb Pokreni navigaciju nije pronađen")
        pokreniButton.tap()

        // Čekaj da se ruta učita i prikaže – kada je ruta aktivna, pojavljuje se gumb "Poništi"
        let ponistiButton = app.buttons["Poništi"]
        XCTAssertTrue(
            ponistiButton.waitForExistence(timeout: 15),
            "Put do Jaruna se nije prikazao – gumb Poništi (aktivna ruta) nije vidljiv u 15 s"
        )
    }

    /// Demo test: vidiš šta radi – korak po korak s dugim pauzama (5 s).
    /// Da vidiš ekran: ostavi prozor Simulatora OTVOREN i klikni u njega da ima fokus prije nego test krene.
    /// Miš u UI testovima često ne animira u Simulatoru; prati PROMJENE NA EKRANU (otvaranje islanda, upis teksta, mapa).
    @MainActor
    func testVidiSeStaRadi() throws {
        let app = XCUIApplication()
        app.launch()

        // Daj si 5 s da prebaciš fokus na Simulator (Window → Simulator ili klik na njega)
        sleep(5)

        try XCTContext.runActivity(named: "1. Čekaj glavni ekran") { _ in
            let islandTitle = app.staticTexts["Porche Ebike"]
            XCTAssertTrue(islandTitle.waitForExistence(timeout: 5))
            sleep(5)
        }

        try XCTContext.runActivity(named: "2. Proširi island (tap na Porche Ebike)") { _ in
            app.staticTexts["Porche Ebike"].tap()
            sleep(5)
        }

        try XCTContext.runActivity(named: "3. Otvori Ruta (tap na ikonu rute)") { _ in
            let routeButton = app.buttons["islandButtonRoute"]
            XCTAssertTrue(routeButton.waitForExistence(timeout: 3))
            routeButton.tap()
            sleep(5)
        }

        try XCTContext.runActivity(named: "4. Unesi polazište: Trg bana Jelačića") { _ in
            let originField = app.textFields["routeOriginField"]
            XCTAssertTrue(originField.waitForExistence(timeout: 3))
            originField.tap()
            originField.typeText("Trg bana Jelačića")
            sleep(5)
        }

        try XCTContext.runActivity(named: "5. Unesi odredište: Jarun jezerok") { _ in
            let destinationField = app.textFields["routeDestinationField"]
            XCTAssertTrue(destinationField.waitForExistence(timeout: 2))
            destinationField.tap()
            destinationField.typeText("Jarun jezerok")
            sleep(5)
        }

        try XCTContext.runActivity(named: "6. Pokreni navigaciju (zeleni gumb)") { _ in
            let pokreniButton = app.buttons["pokreniNavigacijuButton"]
            XCTAssertTrue(pokreniButton.waitForExistence(timeout: 2))
            pokreniButton.tap()
            sleep(5)
        }

        try XCTContext.runActivity(named: "7. Čekaj da se ruta učita – mapa + Poništi") { _ in
            let ponistiButton = app.buttons["Poništi"]
            XCTAssertTrue(ponistiButton.waitForExistence(timeout: 15))
            sleep(5)
        }
    }
}
