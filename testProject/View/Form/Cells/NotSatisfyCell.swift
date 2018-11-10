//
//  NotFoundCell.swift
//  testProject
//
//  Created by Kei Kameda on 2018/11/11.
//  Copyright © 2018年 Kei Kameda. All rights reserved.
//

import UIKit
import DataSourceKit

class NotSatisfyCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private let label = UILabel()

    private func commonInit() {
        selectionStyle = .none
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "---"

        contentView.addSubview(label)

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            label.topAnchor.constraint(equalTo: contentView.topAnchor)
            ])

        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
    }

    func fill(with reason: String) {
        label.text = reason
    }
}

extension NotSatisfyCell: BindableCell {
    typealias Value = String

    static func makeBinder(value: String) -> CellBinder {
        return CellBinder(cellType: self, registrationMethod: .class(self), reuseIdentifier: name, configureCell: { cell in
            cell.fill(with: value)
        })
    }
}

