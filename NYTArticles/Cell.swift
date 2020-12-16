//
//  Cell.swift
//  NYTArticles
//
//  Created by Xenia Sidorova on 16.12.2020.
//

import UIKit

class Cell: UITableViewCell {
    var label: UILabel = {
        var sign = UILabel(frame: CGRect(x: 20.0, y: 15.0, width: 400.0, height: 30))
        return sign
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(label)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
