//
//  RestaurantViewModel.swift
//  Takeaway
//
//  Created by Alin Stafie - Ghilase on 29.12.2021.
//

import UIKit

struct RestaurantViewModel {
    let name: String
    let status: String
    let statusColor: UIColor
    let sortOption: String
    let sortValue: String?
    
    init(with restaurant: Restaurant, sortOption: SortOption) {
        self.name = restaurant.name
        switch restaurant.status {
        case .open:
            self.status = "Open"
            self.statusColor = .green
        case .orderAhead:
            self.status = "Order Ahead"
            self.statusColor = .blue
        case .closed:
            self.status = "Closed"
            self.statusColor = .red
        }
        
        self.sortOption = sortOption.rawValue
        
        var sortValue: String?
        switch sortOption {
        case .alphabetic:
            sortValue =  nil
        case .bestMatch:
            sortValue = "\(restaurant.bestMatch)"
        case .newest:
            sortValue = "\(restaurant.newest)"
        case .rating:
            sortValue = "\(restaurant.ratingAverage)"
        case .distance:
            sortValue = "\(restaurant.distance)"
        case .popularity:
            sortValue = "\(restaurant.popularity)"
        case .cheapest, .expensive:
            sortValue = "\(restaurant.averageProductPrice)"
        case .deliveryCosts:
            sortValue = "\(restaurant.deliveryCosts)"
        case .minOrder:
            sortValue = "\(restaurant.minCost)"
        }
        self.sortValue = sortValue
    }
}
