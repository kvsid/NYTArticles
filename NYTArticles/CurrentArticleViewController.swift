//
//  CurrentArticleViewController.swift
//  NYTArticles
//
//  Created by Xenia Sidorova on 16.12.2020.
//

import UIKit
import WebKit

class CurrentArticleViewController: UIViewController, WKNavigationDelegate {
    private var articleWebView: WKWebView!
    var article: Article?

    override func loadView() {
        articleWebView = WKWebView()
        articleWebView.navigationDelegate = self
        view = articleWebView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Article"
        if let article = article {
            let url = URL(string: article.web_url)!
            articleWebView.load(URLRequest(url: url))
            articleWebView.allowsBackForwardNavigationGestures = true
        }
    }
}
