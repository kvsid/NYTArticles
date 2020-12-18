//
//  Article.swift
//  NYTArticles
//
//  Created by Xenia Sidorova on 16.12.2020.
//

import UIKit

struct APIResponse: Codable {
    var response: ResponseObject
}

struct ResponseObject: Codable {
    var docs: [Article]
}
struct HeadlineObject: Codable {
    var main: String
}

struct Article: Codable {
    var web_url: String
    var headline : HeadlineObject
}
