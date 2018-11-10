//
//  TagBase.swift
//  testProject
//
//  Created by Kei Kameda on 2018/11/10.
//  Copyright © 2018年 Kei Kameda. All rights reserved.
//

import UIKit


@IBDesignable
class TagBase: UIView {

    var label: UILabel!

    @IBInspectable
    var title: String = "tag" {
        didSet {
            label.text = title
        }
    }

    @IBInspectable
    var _indexedStyle: Int = 0 {
        didSet {
            switch _indexedStyle % 3 {
            case 0:
                style = .gray
            case 1:
                style = .slightGray
            case 2:
                style = .yellow
            default:
                style = .gray
            }
        }
    }

    enum Style {
        case yellow
        case gray
        case slightGray
        case slightGrayThin
    }

    var style: Style = .gray {
        didSet {
            switch style {
            case .gray:
                backgroundColor = .gray
                label.textColor = .white
                label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
            case .slightGray:
                backgroundColor = .slightGray
                label.textColor = .textPrimary
                label.font = UIFont.systemFont(ofSize: 14, weight: .light)
            case .yellow:
                backgroundColor = .timeeYellow
                label.textColor = .textPrimary
                label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
            case .slightGrayThin:
                backgroundColor = .slightGray
                label.textColor = .textPrimary
                label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }

    func initView() {
        label = Label()

        label.numberOfLines = 0
        label.textAlignment = .natural

        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12)
            ])

        attachStyle()
    }

    func attachStyle() {
        layer.cornerRadius = 8
        clipsToBounds = true
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        attachStyle()
    }
}
