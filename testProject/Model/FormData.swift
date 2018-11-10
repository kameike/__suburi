//
//  FormData.swift
//  testProject
//
//  Created by Kei Kameda on 2018/11/10.
//  Copyright © 2018年 Kei Kameda. All rights reserved.
//

import Foundation

struct FormData {
    var isComplete: Bool {
        return payload.isSatisfied(for: requirement)
    }

    enum Requirement {
        case required
        case optional

        var stateForView: SelectorHeaderView.State.FormType {
            switch self {
            case .optional:
                return .optional
            case .required:
                return .required
            }
        }
    }

    let requirement: Requirement
    let headerTitle: String
    let payload: Payload
    let id: String

    func invalidReasons() -> [String] {
        let reason = payload.inValidReason(for: requirement)
        return reason.map { "\(headerTitle): \($0)" }
    }

    var headerState: SelectorHeaderView.State {
        let title = headerTitle
        let state = requirement.stateForView
        let isFinished = payload.isSatisfied(for: requirement)

        return SelectorHeaderView.State(
            type: state,
            isFinished: isFinished,
            title: title)
    }
}

enum Payload {
    func isSatisfied(for requirement: FormData.Requirement) ->Bool {
        switch self {
        case .text(let payload):
            return payload.isSatisfied(for: requirement)
        }
    }

    func inValidReason(for requirement: FormData.Requirement) -> [String] {
        switch self {
        case .text(let payload):
            return payload.invalidReason(for: requirement)
        }
    }

    case text(PayloadText)
}

struct PayloadText {
    let validators: [TextValidatable]

    func isSatisfied(for requirement: FormData.Requirement) ->Bool {
        switch requirement {
        case .optional:
            return isValid
        case .required:
            return isFilled && isValid
        }
    }

    var isFilled: Bool {
        return !text.isEmpty
    }

    private var isValid: Bool {
        var isValid = true
        for validator in validators {
            isValid = isValid && validator.validate(text)
        }
        return isValid
    }

    func invalidReason(for requirement: FormData.Requirement) -> [String] {
        switch requirement {
        case .optional:
            break
        case .required:
            if !isFilled {
                return ["必須項目です"]
            }
        }

        return validators
            .filter { !$0.validate(text) }
            .map { $0.reason }
    }

    let text: String
    let description: String
}
