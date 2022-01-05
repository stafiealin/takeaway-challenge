//
//  RestaurantsProvider.swift
//  Takeaway
//
//  Created by Alin Stafie - Ghilase on 05.01.2022.
//

final class RestaurantsProvider: RestaurantsProviderProtocol {
    private let dataProvider: DataProviderProtocol
    
    init(withDataProvider provider: DataProviderProtocol) {
        dataProvider = provider
    }
    
    func getRestaurants(_ completion: @escaping (Result<[Restaurant], NetworkError>) -> Void) {
        getRestaurantsResponse { result in
            switch result {
            case .success(let response):
                completion(.success(response.restaurants))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func getRestaurantsResponse(_ completion: @escaping (Result<RestaurantsResponse, NetworkError>) -> Void) {
        dataProvider.fetchObject(completion)
    }
}
