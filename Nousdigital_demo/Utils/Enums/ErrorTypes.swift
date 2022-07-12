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
            return "Response is not valid"
        case .systemError(let error):
            return error.localizedDescription
        }
    }
}
