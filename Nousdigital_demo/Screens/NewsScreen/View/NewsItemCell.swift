//
//  NewsItemCell.swift
//  Nousdigital_demo
//
//  Created by Ievgenii on 12/07/2022.
//

import UIKit

class NewsItemCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var viewModel: NewsItemCellVM? {
        didSet {
            guard let vm = viewModel else { return }
            titleLabel.text = vm.title
            descriptionLabel.text = vm.description
            setThumbnail(urlString: vm.thumbnailURL)
            
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cleanUp()
    }
    
    private func setThumbnail(urlString: String) {
        thumbnailImageView.kf.indicatorType = .activity
        let placeholderImage = UIImage(named: "placeholder-image")
        thumbnailImageView.kf.setImage(with: URL(string: urlString), placeholder: placeholderImage)
    }
    
    private func cleanUp() {
        thumbnailImageView.kf.cancelDownloadTask()
        thumbnailImageView.kf.setImage(with: URL(string: ""))
        thumbnailImageView.image = nil
    }

}

struct NewsItemCellVM {
    let title: String
    let thumbnailURL: String
    let description: String
    
    init(newsItem: NewsItem) {
        title = newsItem.title
        thumbnailURL = newsItem.imageUrl
        description = newsItem.description
    }
}
