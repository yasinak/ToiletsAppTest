//
//  ToiletsAppTestUITests.swift
//  ToiletsAppTestUITests
//
//  Created by Yasin Akinci on 08/03/2024.
//

import XCTest

class ToiletsAppTestUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testToiletsListScreen() throws {
        let app = XCUIApplication()
        app.launch()

        //  manage system localisation popup
        let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")
        let allowBtn = springboard.buttons["Allow Once"]
        if allowBtn.exists {
            allowBtn.tap()
        }
        
        let myTable = app.tables.matching(identifier: "toiletsListTableViewIdentifier")
        let cell = myTable.cells.element(matching: .cell, identifier: "toiletDetailsTableViewCell_0")
        cell.tap()
        
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
