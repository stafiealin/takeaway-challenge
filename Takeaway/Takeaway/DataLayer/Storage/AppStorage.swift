//
//  AppStorage.swift
//  Takeaway
//
//  Created by Alin Stafie - Ghilase on 04.01.2022.
//

import Foundation

private struct Keys {
    static let sortOptionKey = "selectedSortOption"
}

class AppStorage {
    
    static var selectedSortOption: SortOption {
        get {
            guard let sortOptionRawValue = UserDefaults.standard.value(forKey: Keys.sortOptionKey) as? String,
            let sortOption = SortOption(rawValue: sortOptionRawValue) else {
                return .alphabetic
            }
            return sortOption
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: Keys.sortOptionKey)
        }
    }
}
