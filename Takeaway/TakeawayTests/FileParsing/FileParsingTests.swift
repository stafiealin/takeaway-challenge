//
//  FileParsingTests.swift
//  TakeawayTests
//
//  Created by Alin Stafie - Ghilase on 05.01.2022.
//

import XCTest

class FileParsingTests: XCTestCase {

    let goodJSON = "RestaurantsGoodJSON"
    let wrongJSON = "RestaurantsWrongJSON"
    var fileParser: FileDataProvider!
    
    func testGoodJSONParsingPasses() throws {
        fileParser = FileDataProvider(withFilename: goodJSON)
        do {
            let data = try fileParser.getData()
            let stringData = String(data: data, encoding: .utf8)
            let bundlePath = Bundle.main.path(forResource: goodJSON, ofType: "json")
            let jsonString = try String(contentsOfFile: bundlePath!)
            XCTAssert(stringData == jsonString)
        } catch {
            XCTFail()
        }
    }
    
    func testNonExistingJSONFailsCorrectly() throws {
        fileParser = FileDataProvider(withFilename: wrongJSON)
        do {
            let _ = try fileParser.getData()
            XCTFail()
        } catch let error {
            guard case .fileNotFound = error as? NetworkError else {
                XCTFail()
                return
            }
            XCTAssert(true)
        }
    }
}
