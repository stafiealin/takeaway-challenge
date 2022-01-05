//
//  FileDataProvider.swift
//  Takeaway
//
//  Created by Alin Stafie - Ghilase on 05.01.2022.
//

import Foundation

protocol RawDataProviderProtocol {
    func getData() throws -> Data
}

final class FileDataProvider: RawDataProviderProtocol {
    private let filename: String
    
    init(withFilename name: String) {
        self.filename = name
    }
    
    func getData() throws -> Data {
        do {
            if let bundlePath = Bundle.main.path(forResource: filename, ofType: "json"),
                let fileData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return fileData
            }
        } catch {
            throw NetworkError.badEncoding
        }
        
        throw NetworkError.fileNotFound
    }
}
