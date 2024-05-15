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
}

extension ArticleViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Retorna o número de artigos se houver algum disponível, caso contrário, retorna 1 para mostrar a mensagem de template
        return articleViewModel.articles.isEmpty ? 1 : articleViewModel.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Verifica se há artigos disponíveis
        if articleViewModel.articles.isEmpty {
            // Se não houver artigos, exibe a célula de template com a mensagem adequada
            let cell = tableView.dequeueReusableCell(withIdentifier: "TemplateCell", for: indexPath)
            cell.textLabel?.text = "Nenhum resultado encontrado"
            return cell
        } else {
            // Se houver artigos, exibe os artigos normalmente
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ArticleTableViewCell
            let article = articleViewModel.articles[indexPath.row]
            cell.titleLabel.text = article.title
            cell.authorLabel.text = article.author
            cell.descriptionLabel.text = article.description
            cell.articleImageView.image = UIImage(named: "fallback")
            cell.backgroundColor = UIColor(hex: "#F4F4F4")
            if let imageURL = URL(string: article.urlToImage ?? "") {
                cell.articleImageView.load(url: imageURL)
            }
            return cell
        }
    }
}

extension ArticleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedArticle = articleViewModel.articles[indexPath.row]
        let detailVC = ArticleDetailViewController()
        detailVC.article = selectedArticle
        navigationController?.pushViewController(detailVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ArticleViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let keyword = searchBar.text else { return }
        articleViewModel.fetchArticles(keyword: keyword) { [weak self] in
            DispatchQueue.main.async {
                self?.articleView.tableView.reloadData()
                self?.articleView.templateLabel.isHidden = true
            }
        }
        searchBar.resignFirstResponder()
    }
}
