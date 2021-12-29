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

    func loadModel(_ viewModel: RestaurantViewModel) {
        self.nameLabel.text = viewModel.name
        self.statusLabel.text = viewModel.status
        self.statusLabel.textColor = viewModel.statusColor
    }
}
