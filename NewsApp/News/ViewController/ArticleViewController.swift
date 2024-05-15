//
//  ViewController.swift
//  NewsApp
//
//  Created by Luciano Uchoa on 13/05/24.
//

import UIKit

class ArticleViewController: UIViewController {
    
    var articleViewModel = ArticleViewModel()
    var articleView = ArticleView()
    
    override func loadView() {
        view = articleView
        view.backgroundColor = UIColor(hex: "#2b3a67")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    func setupTableView() {
        articleView.tableView.dataSource = self
        articleView.tableView.delegate = self
        articleView.searchBar.delegate = self
        
        articleView.tableView.layer.masksToBounds = true
        articleView.tableView.separatorStyle =  UITableViewCell.SeparatorStyle.none
        articleView.tableView.backgroundColor = UIColor(hex: "#F4F4F4")
        
        articleView.tableView.rowHeight = UITableView.automaticDimension
        articleView.tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    func showAlert(_ errorMessage: String,title: String? = "") {
        let alertController = UIAlertController(title: title ?? "Error", message: errorMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alertController, animated: true)
    }
}
