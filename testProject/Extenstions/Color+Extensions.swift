//
//  File.swift
//  testProject
//
//  Created by Kei Kameda on 2018/11/10.
//  Copyright © 2018年 Kei Kameda. All rights reserved.
//

import UIKit

extension UIColor {

    convenience init(hex: String, alpha: CGFloat) {
        let value = hex.map { String($0) } + Array(repeating: "0", count: max(6 - hex.count, 0))
        let red = CGFloat(Int(value[0] + value[1], radix: 16) ?? 0) / 255.0
        let green = CGFloat(Int(value[2] + value[3], radix: 16) ?? 0) / 255.0
        let blue = CGFloat(Int(value[4] + value[5], radix: 16) ?? 0) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }

    static var timeeYellow: UIColor {
        return UIColor(hex: "FFCF00", alpha: 1)
    }

    static var slightGray: UIColor {
        return UIColor(hex: "F6F6F6", alpha: 1)
    }

    static var darkGray: UIColor {
        return UIColor(hex: "858E96", alpha: 1)
    }

    static var textPrimary: UIColor {
        return UIColor(hex: "333333", alpha: 1)
    }
}

