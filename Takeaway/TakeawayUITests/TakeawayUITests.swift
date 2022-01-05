//
//  TakeawayUITests.swift
//  TakeawayUITests
//
//  Created by Alin Stafie - Ghilase on 25.12.2021.
//

import XCTest
import Takeaway

class TakeawayUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    func resetSort() {
        let editButton = app.navigationBars["Restaurants"].buttons["edit"]
        editButton.tap()
        app.navigationBars["Sort"].buttons["Reset"].tap()
    }
    
    func applySortOption(_ option: SortOption) {
        let optionString = option.rawValue
        let editButton = app.navigationBars["Restaurants"].buttons["edit"]
        editButton.tap()
                
        app.tables.cells.staticTexts["\(optionString)"].tap()
        app.navigationBars["Sort"].buttons["Apply"].tap()
    }

    func testFilterFunctionality() throws {
        
        let searchField = app.navigationBars["Restaurants"].searchFields["Search Restaurants"]
        searchField.tap()
        searchField.typeText("Ta")
        
        XCTAssertTrue(app.tables.cells/*@START_MENU_TOKEN@*/.staticTexts["Tanoshii Sushi"]/*[[".cells.staticTexts[\"Tanoshii Sushi\"]",".staticTexts[\"Tanoshii Sushi\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.exists)
        XCTAssertTrue(app.tables.cells.staticTexts["Tandoori Express"].exists)
    }
    
    func testSortSelectionUpdatesTableView() throws {
        
        applySortOption(.newest)
        XCTAssertTrue(app.tables.cells.staticTexts["Indian Kitchen"].exists)
        XCTAssertTrue(app.tables.cells.containing(.staticText, identifier:"272.0").staticTexts["Newest"].exists)

        XCTAssertTrue(app.tables.cells.staticTexts["Lunchpakketdienst"].exists)
        XCTAssertTrue(app.tables.cells.containing(.staticText, identifier:"259.0").staticTexts["Newest"].exists)
        resetSort()
    }
    
    func testResetSortHidesSortValuesInTableView() throws {
        
        applySortOption(.newest)
        resetSort()

        XCTAssertFalse(app.tables.cells.containing(.staticText, identifier:"259.0").staticTexts["Newest"].exists)
    }
}
