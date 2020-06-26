//
//  WMP34UITests.swift
//  WMP34UITests
//
//  Created by Ezra Black on 6/22/20.
//  Copyright © 2020 Casanova Studios. All rights reserved.
//

import XCTest

class WMP34UITests: XCTestCase {
    var app: XCUIApplication!
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["UITesting"]
        app.launch()
    }
    func testTypingOnView() throws {
        app.textFields.firstMatch.tap()
        app.textFields.firstMatch.typeText("vincent")
            }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
