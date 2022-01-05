//
//  DataProviderTests.swift
//  TakeawayTests
//
//  Created by Alin Stafie - Ghilase on 05.01.2022.
//

import XCTest

class MockRawDataProvider: RawDataProviderProtocol {
    let dataString: String

    init(dataString: String) {
        self.dataString = dataString
    }
    
    func getData() throws -> Data {
        return dataString.data(using: .utf8)!
    }
}

class DataProviderTests: XCTestCase {

    func getRestaurantsProvider(withString string: String) -> RestaurantsProviderProtocol {
        let rawDataProvider = MockRawDataProvider(dataString: string)
        let dataProvider = DataProvider(withRawDataProvider: rawDataProvider)
        let restaurantsProvider = RestaurantsProvider(withDataProvider: dataProvider)
        
        return restaurantsProvider
    }

    func testRestaurantsStringParsesCorreclty() throws {
        let restaurantsString = "{\r\n  \"restaurants\": [{\r\n    \"name\": \"Tanoshii Sushi\",\r\n    \"status\": \"open\",\r\n    \"sortingValues\": {\r\n      \"bestMatch\": 0.0,\r\n      \"newest\": 96.0,\r\n      \"ratingAverage\": 4.5,\r\n      \"distance\": 1190,\r\n      \"popularity\": 17.0,\r\n      \"averageProductPrice\": 1536,\r\n      \"deliveryCosts\": 200,\r\n      \"minCost\": 1000\r\n    }\r\n  }, {\r\n    \"name\": \"Tandoori Express\",\r\n    \"status\": \"closed\",\r\n    \"sortingValues\": {\r\n      \"bestMatch\": 1.0,\r\n      \"newest\": 266.0,\r\n      \"ratingAverage\": 4.5,\r\n      \"distance\": 2308,\r\n      \"popularity\": 123.0,\r\n      \"averageProductPrice\": 1146,\r\n      \"deliveryCosts\": 150,\r\n      \"minCost\": 1300\r\n    }\r\n  }]\r\n}\r\n"
        let provider = getRestaurantsProvider(withString: restaurantsString)
        provider.getRestaurants { result in
            guard case .success(let restaurants) = result else {
                XCTFail()
                return
            }
            XCTAssert(restaurants.count == 2)
            XCTAssert(restaurants.first?.name == "Tanoshii Sushi")
            XCTAssert(restaurants.last?.name == "Tandoori Express")
        }
    }

    func testBadRestaurantsStringParseFails() throws {
        let restaurantsString = "{\r\n  \"\": [{\r\n    \"name\": \"Tanoshii Sushi\",\r\n    \"status\": \"open\",\r\n    \"sortingValues\": {\r\n      \"bestMatch\": 0.0,\r\n      \"newest\": 96.0,\r\n      \"ratingAverage\": 4.5,\r\n      \"distance\": 1190,\r\n      \"popularity\": 17.0,\r\n      \"averageProductPrice\": 1536,\r\n      \"deliveryCosts\": 200,\r\n      \"minCost\": 1000\r\n    }\r\n  }, {\r\n    \"name\": \"Tandoori Express\",\r\n    \"status\": \"closed\",\r\n    \"sortingValues\": {\r\n      \"bestMatch\": 1.0,\r\n      \"newest\": 266.0,\r\n      \"ratingAverage\": 4.5,\r\n      \"distance\": 2308,\r\n      \"popularity\": 123.0,\r\n      \"averageProductPrice\": 1146,\r\n      \"deliveryCosts\": 150,\r\n      \"minCost\": 1300\r\n    }\r\n  }]\r\n}\r\n"
        let provider = getRestaurantsProvider(withString: restaurantsString)
        provider.getRestaurants { result in
            guard case .failure(let error) = result else {
                XCTFail()
                return
            }
            if case .parsing = error {
                XCTAssert(true)
            } else {
                XCTFail()
            }
        }
    }
}
