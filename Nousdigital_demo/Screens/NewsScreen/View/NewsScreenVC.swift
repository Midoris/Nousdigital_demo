//
//  NewsScreenVC.swift
//  Nousdigital_demo
//
//  Created by Ievgenii on 12/07/2022.
//

import UIKit
import MessageUI
import RxSwift
import RxCocoa

class NewsScreenVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var viewModel = NewsViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialViewSetup()
        setupTable()
    }
    
    private func initialViewSetup() {
        tableView.tableFooterView = UIView()
        title = "News"
    }
    
    private func setupTable() {
        bindTableData()
        setupDidSelect()
        fetchData()
    }
    
    private func bindTableData() {
        let searchTextFieldObservable = searchBar.searchTextField.rx.text.asObservable()
        let itemsObservable = viewModel.newsItems.asObservable()

        Observable.combineLatest(searchTextFieldObservable, itemsObservable)
            .observe(on: MainScheduler.asyncInstance)
            .throttle(.microseconds(500), scheduler: MainScheduler.instance)
            .map { text, list -> [NewsItem] in
                guard let searchedText = text, searchedText.isEmpty == false else {
                    return list
                }
                let filteredItems = list.filter { self.newsFilter($0, searchedText) }
                return filteredItems
            }.bind(
                to: tableView.rx.items(
                    cellIdentifier: NewsItemCell.reuseIdentifier,
                    cellType: NewsItemCell.self)
            ) {  row, model, cell in
                cell.viewModel  = NewsItemCellVM(newsItem: model)
            }.disposed(by: disposeBag)
    }
    
    private var newsFilter: (NewsItem, String) -> Bool = { item, searchedText in
        let lowercasedSearchedText = searchedText.lowercased()
        let containsInTitle = item.title.lowercased().range(of: lowercasedSearchedText) != nil
        let containsInDescription = item.description.lowercased().range(of: lowercasedSearchedText) != nil
        return containsInTitle || containsInDescription
    }
    
    private func setupDidSelect() {
        tableView.rx.modelSelected(NewsItem.self).bind { newsItem in
            self.showEmailForm(newsItem: newsItem)
        }.disposed(by: disposeBag)
    }
    
    private func fetchData() {
        viewModel.fetchNews(onError: { error in
            DispatchQueue.main.async {
                self.showErrorAlert(message: error.message)
            }
        })
    }
        
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Sorry", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func showEmailForm(newsItem: NewsItem) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([])
            mail.setSubject(newsItem.title)
            mail.setMessageBody(newsItem.description, isHTML: false)

            present(mail, animated: true)
        } else {
            showErrorAlert(message: "Your device do not support sending mail or your mailboxes are not setup")
        }
    }

}

extension NewsScreenVC: MFMailComposeViewControllerDelegate {
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}

extension NewsScreenVC {
    static var instance: NewsScreenVC? {
        guard let controller = UIStoryboard(name: "NewsScreen", bundle: nil).instantiateViewController(withIdentifier: String(describing: NewsScreenVC.self)) as? NewsScreenVC else { return nil }
        return controller
    }
}
