//
//  RestaurantTableViewCell.swift
//  Takeaway
//
//  Created by Alin Stafie - Ghilase on 29.12.2021.
//

import UIKit

final class RestaurantTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var statusLabel: UILabel!
    @IBOutlet private weak var sortOptionLabel: UILabel!
    @IBOutlet private weak var sortValueLabel: UILabel!
    @IBOutlet private weak var sortOptionStackView: UIStackView!
    
    func loadModel(_ viewModel: RestaurantViewModel) {
        nameLabel.text = viewModel.name
        statusLabel.text = viewModel.status
        statusLabel.textColor = viewModel.statusColor
        
        sortOptionStackView.isHidden = !viewModel.shouldShowSortValue
        sortValueLabel.text = viewModel.sortValue
        sortOptionLabel.text = viewModel.sortOption
    }
}
