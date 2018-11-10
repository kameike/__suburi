//
//  SelectorContainerView.swift
//  testProject
//
//  Created by Kei Kameda on 2018/11/10.
//  Copyright © 2018年 Kei Kameda. All rights reserved.
//

import UIKit

class SelectorContainerView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        initCommon()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initCommon()
    }

    var textEditableView: TextPayloadView!

    func fill(with payload: Payload) {
        switch payload {
        case .text(let textPayload):
            attachTextEditableView(for: textPayload)
        }
    }

    func attachTextEditableView(for payload: PayloadText) {
        removeOthers()
        addSubview(textEditableView)
        textEditableView.fill(inside: self)
        textEditableView.fill(with: payload)
    }

    private func removeOthers() {
        for subview in subviews {
            subview.removeFromSuperview()
        }
    }

    func initCommon() {
        guard let textEditableView = R.nib.textPayloadView().instantiate(withOwner: nil, options: nil).first as? TextPayloadView else {
            fatalError()
        }
        textEditableView.translatesAutoresizingMaskIntoConstraints = false
        self.textEditableView = textEditableView
    }
}

