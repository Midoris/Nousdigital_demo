//
//  NewsTableView.swift
//  Nousdigital_demo
//
//  Created by Ievgenii on 12/07/2022.
//

import UIKit

protocol NewsTableInteractionViewDelegate: AnyObject {
    func newsItmeSelected(newsItem: NewsItem)
}

class NewsTableView: UITableView {

    weak var ineratcionDelegate: NewsTableInteractionViewDelegate? {
        didSet {
            self.dataSource = self
            self.delegate = self
            self.tableFooterView = UIView()
        }
    }

    var newsItems: [NewsItem] = [] {
        didSet {
            reloadData()
        }
    }
}

extension NewsTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let newsItem = newsItems[safe: indexPath.row] else { return UITableViewCell() }

        let cell: NewsItemCell = tableView.dequeueReusableCell(indexPath: indexPath)
        cell.viewModel = NewsItemCellVM(newsItem: newsItem)
        
        return cell
    }
    
    
}

extension NewsTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let newsItem = newsItems[safe: indexPath.row] else { return }
        ineratcionDelegate?.newsItmeSelected(newsItem: newsItem)
    }
    
}
