//
//
// CodingChallangeUITests.swift
// CodingChallangeUITests
//
// Created by Caio Mansho on 06/07/24
// Copyright © 2024 Caio Mansho. All rights reserved.
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     https://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//


import XCTest
import SwiftUI

final class CodingChallangeUITests: XCTestCase {
    
    private var app: XCUIApplication!
    
    override func setUpWithError() throws { //Does this each time it starts the test
        continueAfterFailure = false
        app = XCUIApplication() // Initializes the XCTest app
        app.launch() // Launches the app
        
    }
    
    override func tearDownWithError() throws { //Does this each time it ends the test
        app = nil //Makes sure that the test wont have residual values, it will be torn down each time the funcion has finished
    }
    
    func testTitleDisplay() { //Checks if the title is being presented
        let titleText = app.staticTexts["Lightning"]
        XCTAssertTrue(titleText.exists)
        
        let navigationBar = app.navigationBars["Lightning"]
        XCTAssertTrue(navigationBar.exists)
    }
    
    func testList() { //Checks if the title is being presented
        // Use the XCUIElementQuery to locate the title Text
        let collectionViewTexts = app.collectionViews["Sidebar"].staticTexts
        
        // Check if the title text is visible
        XCTAssertTrue(collectionViewTexts["Binance"].exists)
        XCTAssertTrue(collectionViewTexts["ACINQ"].exists)
        XCTAssertTrue(collectionViewTexts["bfx-lnd0"].exists)
        XCTAssertTrue(collectionViewTexts["Kraken 🐙⚡"].exists)
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
