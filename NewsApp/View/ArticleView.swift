//
//  View.swift
//  NewsApp
//
//  Created by Luciano Uchoa on 13/05/24.
//

import Foundation
import UIKit

class ArticleView: UIView {
    let tableView = UITableView()
    let searchBar = UISearchBar()
    let templateLabel = UILabel()
    let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    private func setupUI() {
        
        setupTitle()
        setupSearchBar()
        setupTemplate()
        setupTableView()
        
        setupConstraints()
    }

    private func setupTitle() {
        titleLabel.text = "News App"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 32)
        titleLabel.textAlignment = .left
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(titleLabel)
    }
    
    private func setupSearchBar() {
        searchBar.placeholder = "Pesquise por um tópico"
        searchBar.barTintColor = UIColor(hex: "#2b3a67")
        searchBar.setSearchFieldBackgroundColor(.white)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(searchBar)
    }
    
    private func setupTemplate() {
        templateLabel.text = "Nenhum resultado"
        templateLabel.textAlignment = .center
        templateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(templateLabel)
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TemplateCell") 
        tableView.register(ArticleTableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(tableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            searchBar.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            templateLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            templateLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

}

extension ArticleView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
