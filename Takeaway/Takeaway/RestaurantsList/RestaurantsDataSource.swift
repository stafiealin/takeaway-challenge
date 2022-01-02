//
//  RestaurantsDataSource.swift
//  Takeaway
//
//  Created by Alin Stafie - Ghilase on 30.12.2021.
//

protocol RestaurantsViewProtocol: AnyObject {
    func reloadData()
    func showError(message: String)
}

class RestaurantsDataSource {
    
    private var restaurants: [Restaurant] = []
    private var selectionSortOption: SortOption = .alphabetic
    
    weak var delegate: RestaurantsViewProtocol?
    
    func getRestaurants() {
        SessionManager.shared.getRestaurants { [weak self] result in
            switch result {
            case .success(let restaurants):
                self?.restaurants = restaurants
                self?.sortRestaurants()
                self?.delegate?.reloadData()
            case .failure(let error):
                self?.delegate?.showError(message:error.localizedDescription)
            }
        }
    }
    
    var numberOfRestaurants: Int {
        return restaurants.count
    }
    
    func getViewModel(forIndex index: Int) -> RestaurantViewModel {
        
        let restaurant = restaurants[index]
        let viewModel = RestaurantViewModel(with: restaurant, sortOption: selectionSortOption)
        
        return viewModel
    }
    
    func sortRestaurants(withOption option: SortOption = .alphabetic) {
        selectionSortOption = option
        restaurants.sort { first, second in
            return first.compare(with: second, option: option)
        }
    }
}
