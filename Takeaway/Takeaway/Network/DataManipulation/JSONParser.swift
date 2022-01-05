//
//  JSONDataProvider.swift
//  Takeaway
//
//  Created by Alin Stafie - Ghilase on 05.01.2022.
//

import Foundation

protocol RawDataProviderProtocol {
    func getData() throws -> Data
}

final class JSONDataProvider: RawDataProviderProtocol {
    private let filename: String
    
    init(withFilename name: String) {
        self.filename = name
    }
    
    func getData() throws -> Data {
        do {
            if let bundlePath = Bundle.main.path(forResource: filename, ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            throw NetworkError.parsing
        }
        
        throw NetworkError.noData
    }
}
