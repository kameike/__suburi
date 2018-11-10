//
//  SelectorHeaderView.swift
//  testProject
//
//  Created by Kei Kameda on 2018/11/10.
//  Copyright © 2018年 Kei Kameda. All rights reserved.
//

import UIKit

class SelectorHeaderView: UIView {
    struct State {
        enum FormType {
            case required
            case optional
        }
        let type: FormType
        let isFinished: Bool
        let title: String
    }

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    func fill(with state: State) {
        titleLabel.text = state.title

        if state.isFinished {
            statusLabel.textColor = .gray
            statusLabel.text = "ok"
        } else {
            switch state.type {
            case .required:
                statusLabel.text = "必須項目"
                statusLabel.textColor = .red
            case .optional:
                statusLabel.text = "任意"
                statusLabel.textColor = .orange
            }
        }
    }
    
    private func commonInit() {
        guard let view = R.nib.selectorHeader().instantiate(withOwner: self, options: nil).first as? UIView else {
            fatalError()
        }

        view.translatesAutoresizingMaskIntoConstraints = false

        addSubview(view)
        view.fill(inside: self)
    }
}
