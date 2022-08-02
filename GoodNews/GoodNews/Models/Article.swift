//
//  Article.swift
//  GoodNews
//
//  Created by AnhNguyen on 01/08/2022.
//

import Foundation

struct ArticleList: Decodable {
    let articles: [Article]
}

struct Article: Decodable {
    let title: String
    let description: String
}
