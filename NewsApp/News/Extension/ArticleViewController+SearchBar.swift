//
//  ArticleViewController+SearchBar.swift
//  NewsApp
//
//  Created by Luciano Uchoa on 15/05/24.
//

import UIKit

extension ArticleViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let keyword = searchBar.text else { return }
        articleViewModel.getAllArticles(keyword: keyword) { status,message in
            
            if message != "" && !status {
                DispatchQueue.main.async {
                    self.showAlert(message)
                }
            }else {
                DispatchQueue.main.async {
                    self.articleView.tableView.reloadData()
                    self.articleView.templateLabel.isHidden = true
                }
            }
        }
        searchBar.resignFirstResponder()
    }
}
