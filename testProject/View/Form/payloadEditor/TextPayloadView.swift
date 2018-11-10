//
//  TextEditableView.swift
//  testProject
//
//  Created by Kei Kameda on 2018/11/10.
//  Copyright © 2018年 Kei Kameda. All rights reserved.
//

import UIKit

class TextPayloadView: UIView {
    @IBOutlet weak var contentLabel: TagBase!
    
    func fill(with payload: PayloadText) {
        if payload.text.isEmpty {
            contentLabel.title = payload.description
        } else {
            contentLabel.title = payload.text
        }
    }
}
