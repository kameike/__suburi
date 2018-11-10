//
//  Label.swift
//  testProject
//
//  Created by Kei Kameda on 2018/11/10.
//  Copyright © 2018年 Kei Kameda. All rights reserved.
//

import UIKit

@IBDesignable
final class Label: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        attachStyle()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        attachStyle()
    }

    private func attachStyle() {
        
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        if let attributedText = attributedText {
            let t = NSMutableAttributedString(attributedString: attributedText)
            t.addAttribute( NSAttributedStringKey.init(rawValue: (String(kCTLanguageAttributeName))), value: "ja", range: NSRange(location: 0, length: attributedText.string.utf16.count))
            self.attributedText = t
        } else if let text = text {
            attributedText = NSAttributedString(string: text, attributes: [NSAttributedStringKey.init(rawValue: (String(kCTLanguageAttributeName))): "ja", .foregroundColor: textColor, .font: font])
        }
    }
}
