//
//  Validator.swift
//  testProject
//
//  Created by Kei Kameda on 2018/11/10.
//  Copyright © 2018年 Kei Kameda. All rights reserved.
//

import Foundation

protocol TextValidatable {
    func validate(_ text :String) -> Bool
    var reason: String { get }
}

class TooLongTextValidator: TextValidatable {
    init (maxCount: Int) {
        self.maxCount = maxCount
    }

    private let maxCount: Int

    func validate(_ text :String) -> Bool {
        return text.count < maxCount
    }

    var reason: String {
        return "文字数が\(maxCount)よりも多いです。"
    }
}

class NumericValidator: TextValidatable {
    func validate(_ text: String) -> Bool {
        if text.isEmpty {
            return true
        }
        if Int(text) != nil {
            return true
        } else {
            return false
        }
    }

    var reason: String = "数字で入力してください"
}
