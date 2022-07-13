//
//  News.swift
//  Nousdigital_demo
//
//  Created by Ievgenii on 12/07/2022.
//

import Foundation

struct News: Codable {
    var items: [NewsItem]
}

struct NewsItem: Codable {
    var title: String
    var description: String
    var imageUrl: String
}
