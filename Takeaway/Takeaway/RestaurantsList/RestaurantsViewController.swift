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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource.delegate = self
    }
    
    @IBAction func selectedSortOption( _ segue: UIStoryboardSegue) {
        if let controller = segue.source as? SortOptionsViewController {
            let option = controller.selectedSortOption
            dataSource.sortRestaurants(withOption: option)
            tableView.reloadData()
        }
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        dataSource.getRestaurants()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.numberOfRestaurants
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? RestaurantTableViewCell else {
            return UITableViewCell()
        }
        let viewModel = dataSource.getViewModel(forIndex: indexPath.row)
        cell.loadModel(viewModel)
        
        return cell
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
