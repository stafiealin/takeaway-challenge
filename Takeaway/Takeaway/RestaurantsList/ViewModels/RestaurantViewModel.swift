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
    
    init(with restaurant: Restaurant) {
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
    }
}
