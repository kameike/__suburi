//
//  HeaderCell.swift
//  testProject
//
//  Created by Kei Kameda on 2018/11/10.
//  Copyright © 2018年 Kei Kameda. All rights reserved.
//

import UIKit
import DataSourceKit


class FormCell: UITableViewCell {
    @IBOutlet weak var payloadContainer: SelectorContainerView!
    @IBOutlet weak var headerView: SelectorHeaderView!

    private var data: FormData!
    private var bloc: FormBusinessLogicContainer!
    
    func fill(with data: FormData) {
        self.data = data

        for r in gestureRecognizers ?? [] {
            removeGestureRecognizer(r)
        }
        
        headerView.fill(with: data.headerState)
        payloadContainer.fill(with: data.payload)
        let recogniser = UITapGestureRecognizer(target: self, action: #selector(didTap))
        addGestureRecognizer(recogniser)
    }

    @objc func didTap() {
        switch data.payload {
        case .text(let payload):
            let vc = TextEditorViewConroller.viewController(for: payload)
            vc.delegate = self
            window?.rootViewController?.present(vc, animated: true, completion: nil)
        }
    }
}

extension FormCell: UpdateTextDelegate {
    func updateText(_ newPayload: PayloadText) {
        let newData = FormData(requirement: data.requirement, headerTitle: data.headerTitle, payload: .text(newPayload), id: data.id)

        bloc.update(newData)
    }
}

extension FormCell: BindableCell {
    typealias Value = (data: FormData, bloc: FormBusinessLogicContainer)

    static func makeBinder(value: (data: FormData, bloc: FormBusinessLogicContainer)) -> CellBinder {
        return CellBinder(
            cellType: self,
            registrationMethod:.nib(R.nib.formCell()),
            reuseIdentifier: name,
            configureCell: { cell in
                cell.bloc = value.bloc
                cell.fill(with: value.data)})
    }
}
