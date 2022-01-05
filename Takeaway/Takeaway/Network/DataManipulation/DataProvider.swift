//
//  DataProvider.swift
//  Takeaway
//
//  Created by Alin Stafie - Ghilase on 29.12.2021.
//

import Foundation

protocol DataProviderProtocol {
    func fetchObject<DecodeType: Decodable>(_ completion: @escaping (Result<DecodeType, NetworkError>) -> Void)
}

final class DataProvider: DataProviderProtocol {
    
    private let dataProvider: RawDataProviderProtocol
    
    init(withRawDataProvider provider: RawDataProviderProtocol) {
        self.dataProvider = provider
    }
    
    func fetchObject<DecodeType: Decodable>(_ completion: @escaping (Result<DecodeType, NetworkError>) -> Void) {
        
        do {
            let data = try dataProvider.getData()
            let response = try JSONDecoder().decode(DecodeType.self, from: data)
            completion(.success(response))
        } catch {
            completion(.failure(.parsing))
        }
    }
}
