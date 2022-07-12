//
//  NewsScreenVC.swift
//  Nousdigital_demo
//
//  Created by Ievgenii on 12/07/2022.
//

import UIKit
import MessageUI

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
                    self?.showErrorAlert(message: error.message)
                }
            }
        }
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
            showErrorAlert(message: "Your device do not support sending mail")
        }
    }

}

extension NewsScreenVC: NewsTableInteractionViewDelegate {
    func newsItmeSelected(newsItem: NewsItem) {
        showEmailForm(newsItem: newsItem)
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
