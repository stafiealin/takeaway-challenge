//
//  Restaurant+Sorting.swift
//  Takeaway
//
//  Created by Alin Stafie - Ghilase on 02.01.2022.
//

extension RestaurantStatus {    
    var sortValue: Int {
        switch self {
        case .open: return 1
        case .orderAhead: return 2
        case .closed: return 3
        }
    }
}

extension Restaurant {
    
    func compare(with otherRestaurant: Restaurant, option: SortOption) -> Bool {
                
        guard self.status == otherRestaurant.status else {
            return self.status.sortValue < otherRestaurant.status.sortValue
        }
        
        switch option {
        case .alphabetic:
            return self.name < otherRestaurant.name
        case .bestMatch:
            return self.bestMatch > otherRestaurant.bestMatch
        case .newest:
            return self.newest > otherRestaurant.newest
        case .rating:
            return self.ratingAverage > otherRestaurant.ratingAverage
        case .distance:
            return self.distance < otherRestaurant.distance
        case .popularity:
            return self.popularity > otherRestaurant.popularity
        case .cheapest:
            return self.averageProductPrice < otherRestaurant.averageProductPrice
        case .expensive:
            return self.averageProductPrice > otherRestaurant.averageProductPrice
        case .deliveryCosts:
            return self.deliveryCosts > otherRestaurant.deliveryCosts
        case .minOrder:
            return self.minCost < otherRestaurant.minCost
        }
    }
}
