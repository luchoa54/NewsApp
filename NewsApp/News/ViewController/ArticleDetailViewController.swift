//
//  ArticleDetailViewController.swift
//  NewsApp
//
//  Created by Luciano Uchoa on 13/05/24.
//

import Foundation
import UIKit

class ArticleDetailViewController: UIViewController {
    var article: Article? {
        didSet {
            if let article = article {
                configure(with: article)
            }
        }
    }
    
    private let articleDetailView = ArticleDetailView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(hex: "#F4F4F4")
        view.addSubview(articleDetailView)
        articleDetailView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            articleDetailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            articleDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            articleDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            articleDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func configure(with article: Article) {
        articleDetailView.titleLabel.text = article.title
        articleDetailView.authorLabel.text = article.author
        
        let dateString = article.publishedAt
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let date = dateFormatter.date(from: dateString) {
            let outputDateFormatter = DateFormatter()
            outputDateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
            let formattedDate = outputDateFormatter.string(from: date)
            articleDetailView.dateLabel.text = formattedDate
        } else {
            articleDetailView.dateLabel.text = "Data inválida"
        }
        
        articleDetailView.contentLabel.text = article.content
        
        if let image = article.urlToImage {
            articleDetailView.articleImageView.load(url: URL(string: image), fallbackImage: UIImage(named: "fallback"))
            articleDetailView.articleImageView.layer.cornerRadius = 5
            articleDetailView.articleImageView.layer.masksToBounds = true
        }
    }
}
