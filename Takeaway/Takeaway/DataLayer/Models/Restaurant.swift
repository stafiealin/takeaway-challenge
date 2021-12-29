//
//  Restaurant.swift
//  Takeaway
//
//  Created by Alin Stafie - Ghilase on 29.12.2021.
//

enum RestaurantStatus: String, Codable {
    case open
    case orderAhead = "order ahead"
    case closed
}

struct Restaurant: Decodable {
    var name: String = ""
    var status: RestaurantStatus = .closed
    var bestMatch: Double = 0.0
    var newest: Double = 0.0
    var ratingAverage: Double = 0.0
    var distance: Double = 0.0
    var popularity: Double = 0.0
    var averageProductPrice: Double = 0.0
    var deliveryCosts: Double = 0.0
    var minCost: Double = 0.0
    
    private enum CodingKeys: String, CodingKey {
        case name
        case status
        case sortingValues
    }
    
    private enum SortingValuesCodingKeys: String, CodingKey {
        case bestMatch
        case newest
        case ratingAverage
        case distance
        case popularity
        case averageProductPrice
        case deliveryCosts
        case minCost
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        status = try container.decode(RestaurantStatus.self, forKey: .status)
        let sortingValuesContainer = try container.nestedContainer(keyedBy: SortingValuesCodingKeys.self, forKey: .sortingValues)
        bestMatch = try sortingValuesContainer.decode(Double.self, forKey: .bestMatch)
        newest = try sortingValuesContainer.decode(Double.self, forKey: .newest)
        ratingAverage = try sortingValuesContainer.decode(Double.self, forKey: .ratingAverage)
        distance = try sortingValuesContainer.decode(Double.self, forKey: .distance)
        popularity = try sortingValuesContainer.decode(Double.self, forKey: .popularity)
        averageProductPrice = try sortingValuesContainer.decode(Double.self, forKey: .averageProductPrice)
        deliveryCosts = try sortingValuesContainer.decode(Double.self, forKey: .deliveryCosts)
        minCost = try sortingValuesContainer.decode(Double.self, forKey: .minCost)
    }
}
