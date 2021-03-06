//
//  NetworkError.swift
//  Takeaway
//
//  Created by Alin Stafie - Ghilase on 05.01.2022.
//

enum NetworkError: Error {
    case noData
    case parsing
    case badEncoding
    case fileNotFound
    case custom(message: String)
    
    var description: String {
        switch self {
        case .noData: return "Response has no data"
        case .parsing: return "Parsing of the response failed"
        case .badEncoding: return "File had bad encoding"
        case .fileNotFound: return "JSON file not found"
        case .custom(let message): return message
        }
    }
}

