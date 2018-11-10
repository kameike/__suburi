//
//  OkButtonCell.swift
//  testProject
//
//  Created by Kei Kameda on 2018/11/11.
//  Copyright © 2018年 Kei Kameda. All rights reserved.
//

import UIKit
import DataSourceKit
import RxSwift

class OkButtonCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private let button = UIButton()
    private let bag = DisposeBag()

    func commonInit() {
        selectionStyle = .none
        contentView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.timeeYellow, for: .normal)
        button.setTitleColor(UIColor(hex: "DDDDDD", alpha: 1) , for: .disabled)
        button.setTitle("ok", for: .normal)
        button.fill(inside: contentView)

        button.rx.tap.asObservable()
            .bind(onNext: showThankyou)
            .disposed(by: bag)
    }

    func showThankyou() {
        let action = UIAlertAction(title: "ok", style: .default, handler: {_ in})
        let vc = UIAlertController(title: "完了", message: "乙", preferredStyle: .alert)
        vc.addAction(action)
        window?.rootViewController?.present(vc, animated: true, completion: nil)
    }

    func fill(with isReady: Bool) {
        button.isEnabled = isReady
    }
}

extension OkButtonCell: BindableCell {
    typealias Value = Bool

    static func makeBinder(value: Bool) -> CellBinder {
        return CellBinder(
            cellType: self,
            registrationMethod: .class(self),
            reuseIdentifier: name,
            configureCell: { cell in
            cell.fill(with: value)
        })
    }
}
