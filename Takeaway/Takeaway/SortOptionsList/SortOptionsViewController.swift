//
//  SortOptionsViewController.swift
//  Takeaway
//
//  Created by Alin Stafie - Ghilase on 02.01.2022.
//

import UIKit

final class SortOptionsViewController: UITableViewController {
    
    private let cellIdentifier = "SortOptionCell"
    private let selectedSortOptionSegue = "selectedSortOptionSegue"
    
    private var selectedIndexPath: IndexPath!
    
    var selectedSortOption: SortOption = .alphabetic
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SortOption.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? SortOptionTableViewCell else {
            return UITableViewCell()
        }
        
        let option = SortOption.allCases[indexPath.row]
        cell.loadSortOption(option)
        if option == selectedSortOption {
            cell.accessoryType = .checkmark
            selectedIndexPath = indexPath
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        selectedSortOption = SortOption.allCases[indexPath.row]
        
        if let previousCell = tableView.cellForRow(at: selectedIndexPath) {
            previousCell.accessoryType = .none
        }
        
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
        }
        selectedIndexPath = indexPath
    }
    
    @IBAction func reset() {
        selectedSortOption = .alphabetic
        performSegue(withIdentifier: selectedSortOptionSegue, sender: self)
    }
    
    @IBAction func apply() {
        performSegue(withIdentifier: selectedSortOptionSegue, sender: self)
    }
}
