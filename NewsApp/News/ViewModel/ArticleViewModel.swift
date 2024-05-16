//
//  Article.swift
//  NewsApp
//
//  Created by Luciano Uchoa on 13/05/24.
//

import Foundation
import Combine

public typealias CompletionHandler = (_ status: Bool,_ message: String) -> ()

class ArticleViewModel {
    
    var allArticles: [Article] = []
    var allTopHeadlines : [Article] = []
    let newsService: NewsServiceProtocol
    
    init(newsService: NewsServiceProtocol = NewsService.shared) {
        self.newsService = newsService
    }
    
    func getAllArticles(keyword: String, completion: @escaping CompletionHandler) {
        newsService.fetchArticles(keyword: keyword) { [weak self] (articles, error) in
            
            guard Reachability.isInternetAvailable() else {
                completion(false, "No internet connection")
                return
            }
            
            guard let self = self else { return }
            
            if let error = error {
                print("Erro ao buscar os artigos:", error.localizedDescription)
                completion(false, error.localizedDescription)
            } else if let articles = articles {
                if articles.isEmpty {
                    completion(false, "No articles found for the keyword '\(keyword)'")
                } else {
                    self.allArticles = articles
                    completion(true, "")
                }
            }
        }
    }
    
    func getTopHeadlines(country: HeadlineCountry, completion: @escaping CompletionHandler) {
        
        newsService.fetchTopHeadlines(country: .br) { [weak self] (articles, error) in
            guard Reachability.isInternetAvailable() else {
                completion(false, "No internet connection")
                return
            }
            
            guard let self = self else { return }
            
            if let error = error {
                print("Erro ao buscar os artigos:", error.localizedDescription)
                completion(false, error.localizedDescription)
            } else if let articles = articles {
                if articles.isEmpty {
                    completion(false, "No articles found for the country '\(country)'")
                } else {
                    self.allArticles = articles
                    completion(true, "")
                }
            }
        }
    }
    
    
    func numberOfRowsInSection(section: Int) -> Int {
        if allArticles.count != 0 {
            return allArticles.count
        }
        return 0
    }
    
    func cellForRowAt(indexPath: IndexPath) -> Article {
        return allArticles[indexPath.row]
    }
    func sortByDate() {
        allArticles.sort { $0.publishedAt > $1.publishedAt }
    }
}

