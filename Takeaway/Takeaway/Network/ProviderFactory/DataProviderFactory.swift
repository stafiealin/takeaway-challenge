//
//  DataProviderFactory.swift
//  Takeaway
//
//  Created by Alin Stafie - Ghilase on 05.01.2022.
//

protocol RestaurantsProviderProtocol {
    func getRestaurants(_ completion: @escaping (Result<[Restaurant], NetworkError>) -> Void)
}

final class DataProviderFactory {
    private static let restaurantsJSONFilename = "Restaurants"

    static func getRestaurantsProvider() -> RestaurantsProviderProtocol {
        let rawDataProvider = FileDataProvider(withFilename: restaurantsJSONFilename)
        let dataProvider = DataProvider(withRawDataProvider: rawDataProvider)
        let restaurantsProvider = RestaurantsProvider(withDataProvider: dataProvider)
        
        return restaurantsProvider
    }
}
