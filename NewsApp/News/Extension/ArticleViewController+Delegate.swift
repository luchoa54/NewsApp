//
//  ArticleViewController+Delegate.swift
//  NewsApp
//
//  Created by Luciano Uchoa on 15/05/24.
//

import UIKit

extension ArticleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedArticle = articleViewModel.allArticles[indexPath.row]
        let detailVC = ArticleDetailViewController()
        detailVC.article = selectedArticle
        navigationController?.pushViewController(detailVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

