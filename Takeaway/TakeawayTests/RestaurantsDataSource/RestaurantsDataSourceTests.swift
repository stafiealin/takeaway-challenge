//
//  RestaurantsDataSourceTests.swift
//  TakeawayTests
//
//  Created by Alin Stafie - Ghilase on 05.01.2022.
//

import XCTest
@testable import Takeaway

extension Restaurant {
    init(name: String, status: RestaurantStatus, bestMatch: Double, newest: Double, ratingAverage: Double, distance: Double, popularity: Double, averageProductPrice: Double, deliveryCosts: Double, minCost: Double) {
        self.name = name
        self.status = status
        self.bestMatch = bestMatch
        self.newest = newest
        self.ratingAverage = ratingAverage
        self.distance = distance
        self.popularity = popularity
        self.averageProductPrice = averageProductPrice
        self.deliveryCosts = deliveryCosts
        self.minCost = minCost
    }
}

class MockRestaurantsProvider: RestaurantsProviderProtocol {
    private let restaurants: [Restaurant]
    
    init(with restaurants: [Restaurant]) {
        self.restaurants = restaurants
    }
    
    func getRestaurants(_ completion: @escaping (Result<[Restaurant], NetworkError>) -> Void) {
        completion(.success(restaurants))
    }
}

class RestaurantsDataSourceTests: XCTestCase {

    let one = Restaurant(name: "First One", status: .open, bestMatch: 10.1, newest: 20.5, ratingAverage: 67.0, distance: 45, popularity: 58, averageProductPrice: 68, deliveryCosts: 78, minCost: 82)
    let two = Restaurant(name: "Second One", status: .open, bestMatch: 14.4, newest: 25.5, ratingAverage: 45.4, distance: 45, popularity: 58, averageProductPrice: 68, deliveryCosts: 78, minCost: 82)
    let three = Restaurant(name: "Third One", status: .open, bestMatch: 19.0, newest: 67.5, ratingAverage: 89.9, distance: 45, popularity: 58, averageProductPrice: 68, deliveryCosts: 78, minCost: 82)

    func getRestaurantsDataSource(with restaurants: [Restaurant]) -> RestaurantsDataSource {
        let restaurantsProvider = MockRestaurantsProvider(with: restaurants)
        let dataSource = RestaurantsDataSource(withProvider: restaurantsProvider)
        
        return dataSource
    }

    func testRestaurantsAreSortedByStatusByDefault() throws {
        var modifiedTwo = two
        modifiedTwo.status = .orderAhead
        var modifiedThree = three
        modifiedThree.status = .closed
        let restaurants = [modifiedTwo, modifiedThree, one]
        let dataSource = getRestaurantsDataSource(with: restaurants)
        dataSource.getRestaurants()
        XCTAssert(dataSource.getRestaurant(forIndex: 0).status == .open)
        XCTAssert(dataSource.getRestaurant(forIndex: 1).status == .orderAhead)
        XCTAssert(dataSource.getRestaurant(forIndex: 2).status == .closed)
    }

    func testRestaurantsAreSortedAlphabeticallyCorrectly() throws {
        let restaurants = [two, three, one]
        let dataSource = getRestaurantsDataSource(with: restaurants)
        dataSource.getRestaurants()
        dataSource.sortRestaurants(withOption: .alphabetic)
        XCTAssert(dataSource.getRestaurant(forIndex: 0).name == one.name)
        XCTAssert(dataSource.getRestaurant(forIndex: 1).name == two.name)
        XCTAssert(dataSource.getRestaurant(forIndex: 2).name == three.name)
    }

    func testRestaurantsAreSortedByBestMatchCorrectly() throws {
        let restaurants = [two, three, one]
        let dataSource = getRestaurantsDataSource(with: restaurants)
        dataSource.getRestaurants()
        dataSource.sortRestaurants(withOption: .bestMatch)
        XCTAssert(dataSource.getRestaurant(forIndex: 0).bestMatch == three.bestMatch)
        XCTAssert(dataSource.getRestaurant(forIndex: 1).bestMatch == two.bestMatch)
        XCTAssert(dataSource.getRestaurant(forIndex: 2).bestMatch == one.bestMatch)
    }

    func testRestaurantsAreSortedByNewestCorrectly() throws {
        let restaurants = [two, three, one]
        let dataSource = getRestaurantsDataSource(with: restaurants)
        dataSource.getRestaurants()
        dataSource.sortRestaurants(withOption: .newest)
        XCTAssert(dataSource.getRestaurant(forIndex: 0).newest == three.newest)
        XCTAssert(dataSource.getRestaurant(forIndex: 1).newest == two.newest)
        XCTAssert(dataSource.getRestaurant(forIndex: 2).newest == one.newest)
    }

    func testRestaurantsAreSortedByRatingCorrectly() throws {
        let restaurants = [two, three, one]
        let dataSource = getRestaurantsDataSource(with: restaurants)
        dataSource.getRestaurants()
        dataSource.sortRestaurants(withOption: .rating)
        XCTAssert(dataSource.getRestaurant(forIndex: 0).ratingAverage == three.ratingAverage)
        XCTAssert(dataSource.getRestaurant(forIndex: 1).ratingAverage == one.ratingAverage)
        XCTAssert(dataSource.getRestaurant(forIndex: 2).ratingAverage == two.ratingAverage)
    }
}
