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
    let newsService: NewsServiceProtocol
    
    init(newsService: NewsServiceProtocol = NewsService.shared) {
        self.newsService = newsService
    }
    
    func fetchArticles(keyword: String, completion: @escaping CompletionHandler) {
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

import SystemConfiguration

public class Reachability {
    //===================================================================================================
    //functions for check internet avaiability before submiting the request / while prcessing the request
    //===================================================================================================
    
    class func isInternetAvailable() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
}
