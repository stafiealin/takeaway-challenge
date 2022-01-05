//
//  SortOptionTableViewCell.swift
//  Takeaway
//
//  Created by Alin Stafie - Ghilase on 02.01.2022.
//

import UIKit

final class SortOptionTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var sortOptionLabel: UILabel!
    
    func loadSortOption(_ option: SortOption) {
        self.sortOptionLabel.text = option.rawValue
    }
}
