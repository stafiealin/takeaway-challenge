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

final class RestaurantsDataSource {
    
    private let restaurantsProvider: RestaurantsProviderProtocol
    private var restaurants: [Restaurant] = []
    private var filteredRestaurants: [Restaurant] = []
    private var selectedSortOption: SortOption {
        didSet {
            AppStorage.selectedSortOption = selectedSortOption
        }
    }
    
    weak var delegate: RestaurantsViewProtocol?
    
    init(withProvider provider: RestaurantsProviderProtocol) {
        restaurantsProvider = provider
        selectedSortOption = AppStorage.selectedSortOption
    }
    
    func getRestaurants() {
        restaurantsProvider.getRestaurants { [weak self] result in
                guard let self = self else {
                    return
                }
                switch result {
                case .success(let restaurants):
                    self.restaurants = restaurants
                    self.sortRestaurants(withOption: self.selectedSortOption)
                    self.delegate?.reloadData()
                case .failure(let error):
                    self.delegate?.showError(message:error.localizedDescription)
                }
        }
    }
    
    func numberOfRestaurants(isFiltering: Bool = false) -> Int {
        if isFiltering {
            return filteredRestaurants.count
        }
        return restaurants.count
    }
    
    func getRestaurant(forIndex index: Int, isFiltering: Bool = false) -> Restaurant {
        let list = isFiltering ? filteredRestaurants : restaurants
        return list[index]
    }
        
    func getRestaurantViewModel(forIndex index: Int, isFiltering: Bool = false) -> RestaurantViewModel {
        
        let restaurant = getRestaurant(forIndex: index, isFiltering: isFiltering)
        let viewModel = RestaurantViewModel(with: restaurant, sortOption: selectedSortOption)
        
        return viewModel
    }
    
    func sortRestaurants(withOption option: SortOption = .alphabetic) {
        selectedSortOption = option
        restaurants.sort { first, second in
            return first.compare(with: second, option: option)
        }
        delegate?.reloadData()
    }
    
    func filterRestaurants(byName searchString: String) {
        filteredRestaurants = restaurants.filter({
            $0.name.contains(searchString)
        })
        
        delegate?.reloadData()
    }
}
