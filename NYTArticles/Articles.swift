//
//  Articles.swift
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

struct Article: Codable {
    var lead_paragraph: String
    var web_url: String
}


