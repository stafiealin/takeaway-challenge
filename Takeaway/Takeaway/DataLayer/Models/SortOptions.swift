//
//  SortOptions.swift
//  Takeaway
//
//  Created by Alin Stafie - Ghilase on 02.01.2022.
//

enum SortOption: String, CaseIterable {
    case alphabetic = "Alphabetic"
    case bestMatch = "Best Match"
    case newest = "Newest"
    case rating = "Highest Rating"
    case distance = "Closest to you"
    case popularity = "Popularity"
    case cheapest = "Lowest Prices"
    case expensive = "Expensive First"
    case deliveryCosts = "Delivery Costs"
    case minOrder = "Minimum Order"
}
