//
//  SessionManager.swift
//  Takeaway
//
//  Created by Alin Stafie - Ghilase on 29.12.2021.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case noData
    case parsing
    case custom(message: String)
    
    var description: String {
        switch self {
        case .badURL: return "URL has bad format"
        case .noData: return "Response has no data"
        case .parsing: return "Parsing of the response failed"
        case .custom(let message): return message
        }
    }
}

class SessionManager {
    
    static let shared = SessionManager()
    private let restaurantsJSONFilename = "Restaurants"
    private let urlSession = URLSession.init(configuration: .default)
 
    public func getRestaurants(_ completion: @escaping (Result<[Restaurant], NetworkError>) -> Void) {
        
        guard let data = getJSONData(fromFile: restaurantsJSONFilename) else {
            completion(.failure(NetworkError.noData))
            return
        }
        
        do {
            let restaurantsResponse = try JSONDecoder().decode(RestaurantsResponse.self, from: data)
            completion(.success(restaurantsResponse.restaurants))
        } catch {
            completion(.failure(NetworkError.parsing))
        }
    }
    
    func getJSONData(fromFile fileName: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: fileName, ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
}
