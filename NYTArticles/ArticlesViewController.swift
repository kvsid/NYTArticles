//
//  ArticlesViewController.swift
//  NYTArticles
//
//  Created by Xenia Sidorova on 16.12.2020.
//

import UIKit

class ArticlesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private var articlesTable = UITableView()
    var category: String?

    var articles = [Article]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = category
        view.backgroundColor = .white
        setupTable()
        requestArticles()

        
    }
    private func setupTable() {
        articlesTable = UITableView(frame: view.bounds, style: .plain)
        articlesTable.delegate = self
        articlesTable.dataSource = self
        articlesTable.register(Cell.self, forCellReuseIdentifier: "Cell")

        view.addSubview(articlesTable)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
        let currentArticle = articles[indexPath.row]
        cell.label.text = currentArticle.lead_paragraph
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      let article = CurrentArticleViewController()
        article.currentArticle = articles[indexPath.row]
      navigationController?.pushViewController(article, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }


        private func requestArticles() {
            if let category = category {
                let originalUrlString = "https://api.nytimes.com/svc/search/v2/articlesearch.json?api-key=nQIkx0QlHCglGGGCuIyg4Fnf391xUubA&fq=news_desk:\(category)"
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

