//
//  ErrorTypes.swift
//  Nousdigital_demo
//
//  Created by Ievgenii on 12/07/2022.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidData
    case systemError(Error)
    
    var message: String {
        switch self {
        case .invalidURL:
            return "Provided URL is not valid"
        case .invalidData:
            return "Could not fetch data"
        case .systemError(let error):
            return error.localizedDescription
        }
    }
}
