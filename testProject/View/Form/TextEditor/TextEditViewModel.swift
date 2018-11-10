//
//  TextEditViewModel.swift
//  testProject
//
//  Created by Kei Kameda on 2018/11/10.
//  Copyright © 2018年 Kei Kameda. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class TextEditViewModel {
    let payload: PayloadText

    let query: BehaviorRelay<String>

    let validRelay = BehaviorRelay<Bool>(value: true)
    let invalidReasonRelay = BehaviorRelay<String?>(value: nil)
    let bag = DisposeBag()
    weak var delegate: UpdateTextDelegate?

    init(payload: PayloadText) {
        self.payload = payload
        print(payload.text)
        query = BehaviorRelay<String>(value: payload.text)

        query
            .map(isValidQuery)
            .distinctUntilChanged()
            .bind(to: validRelay)
            .disposed(by: bag)

        validRelay
            .map(invalidReason)
            .distinctUntilChanged()
            .bind(to: invalidReasonRelay)
            .disposed(by: bag)
    }

    private func invalidReason(isValid: Bool) -> String {
        var reasons = ""

        for v in payload.validators {
            if !v.validate(query.value) {
                reasons = "\(reasons), \(v.reason)"
            }
        }
        return reasons
    }

    func updateBloc() {
        let textPayload = PayloadText(
            validators: payload.validators,
            text: query.value,
            description: payload.description)

        delegate?.updateText(textPayload)
    }

    func isValidQuery(_ query: String) -> Bool {
        var valid = true
        for v in payload.validators {
            valid = valid && v.validate(query)
        }

        return valid
    }
}
