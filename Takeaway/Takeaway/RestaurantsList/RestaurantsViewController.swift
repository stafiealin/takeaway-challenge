//
//  RestaurantsViewController.swift
//  Takeaway
//
//  Created by Alin Stafie - Ghilase on 29.12.2021.
//

import UIKit

class RestaurantsViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SessionManager.shared.getRestaurants { result in
            switch result {
            case .success(let restaurants):
                print(restaurants)
            case .failure(let error):
                print(error)
            }
        }
    }
}
