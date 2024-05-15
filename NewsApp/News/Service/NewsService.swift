//
//  NewsService.swift
//  NewsApp
//
//  Created by Luciano Uchoa on 14/05/24.
//

import Foundation
import Combine

enum HeadlineCountry: String {
    case ae, ar, at, au, be, bg, br, ca, ch, cn, co, cu, cz, de, eg, fr, gb, gr, hk, hu, id, ie, il, `in`, it, jp, kr, lt, lv, ma, mx, my, ng, nl, no, nz, ph, pl, pt, ro, rs, ru, sa, se, sg, si, sk, th, tr, tw, ua, us, ve, za

    var countryCode: String {
        return self.rawValue
    }
}


protocol NewsServiceProtocol {
    func fetchArticles(keyword: String, completion: @escaping ([Article]?, Error?) -> Void)
    func fetchTopHeadlines(country: HeadlineCountry, completion: @escaping ([Article]?, Error?) -> Void)
}

class NewsService: NewsServiceProtocol {
    
    static let shared = NewsService()
    
    private init() {}
    
    func fetchArticles(keyword: String, completion: @escaping ([Article]?, Error?) -> Void) {
        
        let apiKey = ProcessInfo.processInfo.environment["NEWS_API_KEY"]
        
        guard let url = URL(string: "https://newsapi.org/v2/everything?q=\(keyword)&apiKey=\(apiKey ?? "")") else {
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
    
    func fetchTopHeadlines(country: HeadlineCountry, completion: @escaping ([Article]?, Error?) -> Void) {
        let apiKey = ProcessInfo.processInfo.environment["NEWS_API_KEY"]
        
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?country=\(HeadlineCountry.self)&apiKey=\(apiKey ?? "")") else {
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
                let filteredHeadlines = response.articles.filter {$0.title != "[Removed]"}
                completion(filteredHeadlines, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
}
