//
//  ArticleViewController+DataSource.swift
//  NewsApp
//
//  Created by Luciano Uchoa on 15/05/24.
//

import UIKit

extension ArticleViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleViewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !articleViewModel.allArticles.isEmpty else {
            return setupTemplateCell(for: indexPath, in: tableView)
        }
        
        let cell = setupArticleCell(for: indexPath, in: tableView)
        return cell
    }
    
    private func setupTemplateCell(for indexPath: IndexPath, in tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TemplateCell", for: indexPath)
        cell.textLabel?.text = "Nenhum resultado encontrado"
        return cell
    }
    
    private func setupArticleCell(for indexPath: IndexPath, in tableView: UITableView) -> ArticleTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ArticleTableViewCell
        let article = articleViewModel.allArticles[indexPath.row]
        configureCell(cell, with: article)
        return cell
    }
    
    private func configureCell(_ cell: ArticleTableViewCell, with article: Article) {
        cell.titleLabel.text = article.title
        cell.authorLabel.text = article.author
        cell.descriptionLabel.text = article.description
        cell.articleImageView.image = UIImage(named: "fallback")
        cell.backgroundColor = UIColor(hex: "#F4F4F4")
        if let imageURL = URL(string: article.urlToImage ?? "") {
            cell.articleImageView.load(url: imageURL)
        }
    }
}

