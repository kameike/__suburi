//
//  MainCell.swift
//  testProject
//
//  Created by Kei Kameda on 2018/11/11.
//  Copyright © 2018年 Kei Kameda. All rights reserved.
//

import UIKit
import DataSourceKit

class MainCell: UITableViewCell {
    var data: [FormData]!
    @IBOutlet weak var tab: TagBase!

    func fill(_ target: [FormData]) {
        for recognizer in gestureRecognizers ?? [] {
            removeGestureRecognizer(recognizer)
        }

        data = target
        tab.title = "\(target.count)個"

        let recognizer = UITapGestureRecognizer(target: self, action: #selector(didTap))
        addGestureRecognizer(recognizer)
    }

    @objc func didTap() {
        let vc = FormViewController.viewController(data: data)

        window?.rootViewController?.childViewControllers.first?.navigationController?.pushViewController(vc, animated: true)
    }
}

extension MainCell: BindableCell {
    static func makeBinder(value: [FormData]) -> CellBinder {
        return CellBinder(
            cellType: self,
            registrationMethod: .nib(R.nib.mainCell()),
            reuseIdentifier: name,
            configureCell: { $0.fill(value) })
    }

    typealias Value = [FormData]
}
