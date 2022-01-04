//
//  RestaurantsViewController.swift
//  Takeaway
//
//  Created by Alin Stafie - Ghilase on 29.12.2021.
//

import UIKit

class RestaurantsViewController: UITableViewController {
    
    private let cellIdentifier = "RestaurantCell"
    private let dataSource = RestaurantsDataSource()
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search Restaurants"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        dataSource.delegate = self
    }
    
    @IBAction func selectedSortOption( _ segue: UIStoryboardSegue) {
        if let controller = segue.source as? SortOptionsViewController {
            let option = controller.selectedSortOption
            dataSource.sortRestaurants(withOption: option)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        dataSource.getRestaurants()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.numberOfRestaurants(isFiltering: isFiltering)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? RestaurantTableViewCell else {
            return UITableViewCell()
        }
        let viewModel = dataSource.getRestaurantViewModel(forIndex: indexPath.row, isFiltering: isFiltering)
        cell.loadModel(viewModel)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension RestaurantsViewController: RestaurantsViewProtocol {
    
    func reloadData() {
        DispatchQueue.main.async { [unowned self] in
            self.tableView.reloadData()
        }
    }
    
    func showError(message: String) {
        DispatchQueue.main.async { [unowned self] in
            let alert = UIAlertController(title: "Oops..", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension RestaurantsViewController: UISearchResultsUpdating {
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            dataSource.filterRestaurants(byName: searchText)
        }
    }
}
