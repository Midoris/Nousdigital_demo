//
//  NewsViewModel.swift
//  Nousdigital_demo
//
//  Created by Ievgenii on 13/07/2022.
//

import Foundation
import RxSwift

struct NewsViewModel {
    
    var newsItems = PublishSubject<[NewsItem]>()
    
    func fetchNews(onError: @escaping (NetworkError) -> Void) {
        NewsFetcher.fetchNews { result in
            switch result {
            case .success(let news):
                newsItems.onNext(news.items)
                newsItems.onCompleted()
            case .failure(let error):
                onError(error)
            }
        }
    }
}
