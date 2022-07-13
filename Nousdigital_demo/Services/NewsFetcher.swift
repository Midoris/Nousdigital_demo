//
//  NewsFetcher.swift
//  Nousdigital_demo
//
//  Created by Ievgenii on 12/07/2022.
//

import Foundation
import Alamofire

struct NewsFetcher {
    private static let urlPath = "https://cloud.nousdigital.net/s/rNPWPNWKwK7kZcS/download"
    
    static func fetchNews(completion: @escaping (Result<News, NetworkError>) -> Void) {
        guard let url = URL(string: urlPath) else {
            completion(.failure(.invalidURL))
            return
        }

        AF.request(url, method: .get)
            .responseData { response in
                guard let data = response.data else {
                    completion(.failure(.invalidData))
                    return
                }

                let decoder = JSONDecoder()
                do {
                    let news = try decoder.decode(News.self, from: data)
                    completion(.success(news))
                } catch {
                    completion(.failure(.systemError(error)))
                }                
            }
    }
}
