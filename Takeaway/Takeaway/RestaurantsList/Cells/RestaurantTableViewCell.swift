//
//  RestaurantTableViewCell.swift
//  Takeaway
//
//  Created by Alin Stafie - Ghilase on 29.12.2021.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var sortOptionLabel: UILabel!
    @IBOutlet weak var sortValueLabel: UILabel!
    @IBOutlet weak var sortOptionStackView: UIStackView!
    
    func loadModel(_ viewModel: RestaurantViewModel) {
        nameLabel.text = viewModel.name
        statusLabel.text = viewModel.status
        statusLabel.textColor = viewModel.statusColor
        
        sortOptionStackView.isHidden = !viewModel.shouldShowSortValue
        sortValueLabel.text = viewModel.sortValue
        sortOptionLabel.text = viewModel.sortOption
    }
}
