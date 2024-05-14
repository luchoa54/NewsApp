//
//  Article.swift
//  NewsApp
//
//  Created by Luciano Uchoa on 13/05/24.
//

import Foundation
import Combine

class ArticleViewModel {
    
    var articles: [Article] = []
    let newsService: NewsServiceProtocol
    
    init(newsService: NewsServiceProtocol = NewsService.shared) {
        self.newsService = newsService
    }
    
    func fetchArticles(keyword: String, completion: @escaping () -> Void) {
        newsService.fetchArticles(keyword: keyword) { [weak self] (articles, error) in
            guard let self = self else { return }
            
            if let error = error {
                print("Erro ao buscar os artigos:", error.localizedDescription)
            } else if let articles = articles {
                self.articles = articles
                completion()
            }
        }
    }
}
