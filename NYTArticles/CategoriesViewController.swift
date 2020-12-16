//
//  CategoriesViewController.swift
//  NYTArticles
//
//  Created by Xenia Sidorova on 16.12.2020.
//

import UIKit

class CategoriesViewController: UIViewController, UITableViewDataSource {
    private let articles = ArticlesViewController()
    private var categoriesTable = UITableView()
    public var categories = ["Adventure Sports", "Arts & Leisure", "Arts", "Automobiles", "Blogs", "Books", "Booming"]
//    var currentCategory : String? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Categories"
        view.backgroundColor = .white
        setupTable()
    }


    private func setupTable() {
        categoriesTable = UITableView(frame: view.bounds, style: .plain)
        categoriesTable.delegate = self
        categoriesTable.dataSource = self
        categoriesTable.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        categoriesTable.register(Cell.self, forCellReuseIdentifier: "Cell")

        view.addSubview(categoriesTable)
    }
}

extension CategoriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
        let currentCategory = categories[indexPath.row]
        cell.label.text = currentCategory

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCategory = categories[indexPath.row]
        let articlesVC = ArticlesViewController()
        articlesVC.category = currentCategory
        navigationController?.pushViewController(articlesVC, animated: true)
    }

}
