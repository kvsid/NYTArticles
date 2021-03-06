//
//  CategoriesViewController.swift
//  NYTArticles
//
//  Created by Xenia Sidorova on 16.12.2020.
//

import UIKit

class CategoriesViewController: UIViewController, UITableViewDataSource {
    private var categoriesTable = UITableView()
    private var categories = [
        "Adventure Sports", "Arts & Leisure", "Arts", "Automobiles",
        "Blogs", "Books", "Booming", "Culture", "Flight", "Generations"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Categories"
        view.backgroundColor = .white
        setupTable()
    }

    private func setupTable() {
        categoriesTable = UITableView(frame: view.frame, style: .plain)
        categoriesTable.delegate = self
        categoriesTable.dataSource = self
        categoriesTable.register(UITableViewCell.self, forCellReuseIdentifier: "category")

        view.addSubview(categoriesTable)
    }
}

extension CategoriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "category", for: indexPath)
        let currentCategory = categories[indexPath.row]
        cell.textLabel?.text = currentCategory

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCategory = categories[indexPath.row]
        let articlesVC = ArticlesViewController()
        articlesVC.category = currentCategory
        navigationController?.pushViewController(articlesVC, animated: true)
    }
}
