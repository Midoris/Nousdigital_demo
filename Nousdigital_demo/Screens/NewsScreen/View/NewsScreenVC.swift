//
//  NewsScreenVC.swift
//  Nousdigital_demo
//
//  Created by Ievgenii on 12/07/2022.
//

import UIKit
import Kingfisher

class NewsScreenVC: UIViewController {

    @IBOutlet weak var tableView: NewsTableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialViewSetup()
        fetchNews()
    }
    
    private func initialViewSetup() {
        tableView.ineratcionDelegate = self
        title = "News"
    }
    
    private func fetchNews() {
        NewsFetcher.fetchNews { result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let news):
                    self?.tableView.newsItems = news.items
                case .failure(let error):
                    self?.showErrorAlert(error: error)
                }
            }
        }
    }
    
    private func showErrorAlert(error: NetworkError) {
        let alert = UIAlertController(title: "Sorry", message: error.message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
}

extension NewsScreenVC: NewsTableInteractionViewDelegate {
    
}

extension NewsScreenVC {
    static var instance: NewsScreenVC? {
        guard let controller = UIStoryboard(name: "NewsScreen", bundle: nil).instantiateViewController(withIdentifier: String(describing: NewsScreenVC.self)) as? NewsScreenVC else { return nil }
        return controller
    }
}
