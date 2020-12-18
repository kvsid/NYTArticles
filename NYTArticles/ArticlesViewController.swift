//
//  ArticlesViewController.swift
//  NYTArticles
//
//  Created by Xenia Sidorova on 16.12.2020.
//

import UIKit

class ArticlesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var category: String?

    private var articlesTable = UITableView()
    private var articles = [Article]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = category
        setupTable()
        requestArticles()
    }

    private func setupTable() {
        articlesTable = UITableView(frame: view.bounds, style: .plain)
        articlesTable.delegate = self
        articlesTable.dataSource = self
        articlesTable.register(UITableViewCell.self, forCellReuseIdentifier: "article")

        view.addSubview(articlesTable)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "article", for: indexPath)
        let currentArticle = articles[indexPath.row]
        if let label = cell.textLabel {
            label.text = currentArticle.headline.main
            label.numberOfLines = 0
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      let currentArticleVC = CurrentArticleViewController()
        currentArticleVC.article = articles[indexPath.row]
      navigationController?.pushViewController(currentArticleVC, animated: true)
    }

    private func requestArticles() {
        if let category = category {
            let originalUrlString = "https://api.nytimes.com/svc/search/v2/articlesearch" +
                ".json?api-key=nQIkx0QlHCglGGGCuIyg4Fnf391xUubA&fq=news_desk:\(category)"
            let urlString = originalUrlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            let url = URL(string: urlString!)!

            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil, response != nil else {
                    print("Something went wrong. The data nil")
                    return
                }
                do {
                    let decodedData = try JSONDecoder().decode(APIResponse.self, from: data)
                    self.articles = decodedData.response.docs
                    DispatchQueue.main.async {
                        self.articlesTable.reloadData()
                    }
                } catch {
                    print("Something went wrong")
                }
            }.resume()
        }
    }
}
