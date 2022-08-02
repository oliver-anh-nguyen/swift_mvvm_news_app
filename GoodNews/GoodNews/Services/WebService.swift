//
//  WebService.swift
//  GoodNews
//
//  Created by AnhNguyen on 01/08/2022.
//

import Foundation

class WebService {
    
    func getArticles(url: URL, completion: @escaping ([Article]?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, res, err in
            if let err = err {
                print(err.localizedDescription)
                completion(nil)
            }
            guard let data = data  else { return }
            do {
                let articles = try JSONDecoder().decode(ArticleList.self, from: data)
                completion(articles.articles)
                print(articles)
            } catch {
                print(error.localizedDescription)
            }
            
            
        }.resume()
    }
}
