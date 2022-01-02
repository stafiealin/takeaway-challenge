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
        self.nameLabel.text = viewModel.name
        self.statusLabel.text = viewModel.status
        self.statusLabel.textColor = viewModel.statusColor
        
        if let value = viewModel.sortValue {
            sortValueLabel.text = value
            sortOptionLabel.text = viewModel.sortOption
            sortOptionStackView.isHidden = false
        } else {
            sortOptionStackView.isHidden = true
        }
    }
}
