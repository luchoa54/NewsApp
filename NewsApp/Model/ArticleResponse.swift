//
//  ArticleResponse.swift
//  NewsApp
//
//  Created by Luciano Uchoa on 13/05/24.
//

import Foundation

struct ArticleResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}
