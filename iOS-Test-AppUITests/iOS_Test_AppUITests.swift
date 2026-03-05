//
//  iOS_Test_AppUITests.swift
//  iOS-Test-AppUITests
//
//  Created by Lazar Stojkovic on 3/4/26.
//

import XCTest

final class iOS_Test_AppUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUp() {
        continueAfterFailure = false
        app.launch()
    }

    func testNavigationToDetails() {
        let firstCell = app.tables.cells.firstMatch
        XCTAssertTrue(firstCell.waitForExistence(timeout: 5))
        
        firstCell.tap()
        
        let tagsHeader = app.staticTexts["Tags"]
        XCTAssertTrue(tagsHeader.exists, "Screen with details didn't open or it doesn't show tag section.")
    }
}
