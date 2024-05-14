//
//  NewsService.swift
//  NewsApp
//
//  Created by Luciano Uchoa on 14/05/24.
//

import Foundation
import Combine

protocol NewsServiceProtocol {
    func fetchArticles(keyword: String, completion: @escaping ([Article]?, Error?) -> Void)
}

class NewsService: NewsServiceProtocol {
    
    static let shared = NewsService()
    
    private init() {}
    
    func fetchArticles(keyword: String, completion: @escaping ([Article]?, Error?) -> Void) {
        guard let url = URL(string: "https://newsapi.org/v2/everything?q=\(keyword)&apiKey=2f268150c5df4bd2a7dda5825bc8f848") else {
            completion(nil, NSError(domain: "Invalid URL", code: -1, userInfo: nil))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil, error)
                return
            }
            
            do {
                let response = try JSONDecoder().decode(ArticleResponse.self, from: data)
                let filteredArticles = response.articles.filter { $0.title != "[Removed]" }
                completion(filteredArticles, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
}
