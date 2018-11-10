//
//  View+Extensinos.swift
//  testProject
//
//  Created by Kei Kameda on 2018/11/10.
//  Copyright © 2018年 Kei Kameda. All rights reserved.
//

import UIKit


extension UITableViewCell {
    static var name: String {
        return String.init(describing: self)
    }
}


extension UIView {
    func fill(inside superView: UIView) {
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superView.topAnchor),
            bottomAnchor.constraint(equalTo: superView.bottomAnchor),
            leadingAnchor.constraint(equalTo: superView.leadingAnchor),
            trailingAnchor.constraint(equalTo: superView.trailingAnchor)
            ])
    }
}

