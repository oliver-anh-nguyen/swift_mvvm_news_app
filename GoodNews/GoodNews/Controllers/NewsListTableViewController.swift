//
//  NewsListTableViewController.swift
//  GoodNews
//
//  Created by AnhNguyen on 01/08/2022.
//

import Foundation
import UIKit

class NewsListTableViewController: UITableViewController {
    
    private var articleListVM: ArticleListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    private func setUp() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        let url = URL(string:"https://newsapi.org/v2/everything?q=tesla&from=2022-07-02&sortBy=publishedAt&apiKey=5a9a62755e33403fbe53f9c375271e48")!
        WebService().getArticles(url: url) { [weak self] articles in
            if let articles = articles {
                self?.articleListVM = ArticleListViewModel(articles: articles)
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.articleListVM == nil ? 0 : self.articleListVM.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articleListVM.numberOfRowsInSection(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell else {
            fatalError("ArticleTableViewCell not found")
        }
        
        let article = self.articleListVM.articleAtIndex(indexPath.row)
        cell.titleLabel.text = article.title
        cell.descriptionLabel.text = article.description
        return cell
    }
}
