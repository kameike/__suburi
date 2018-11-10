//
//  FormBusinessLogicContainer.swift
//  testProject
//
//  Created by Kei Kameda on 2018/11/10.
//  Copyright © 2018年 Kei Kameda. All rights reserved.
//

import Foundation
import RxCocoa


class FormBusinessLogicContainer {
    private(set) var data: [String:FormData] = [:]
    let updatePublisher = PublishRelay<Void>()

    var valid: Bool {
        var result = true
        for t in data {
            result = result && t.value.isComplete
        }
        return result
    }

    init(formData: [FormData]) {
        for target in formData {
            data[target.id] = target
        }
    }

    func update(_ newData: FormData) {
        if data[newData.id] == nil {
            assertionFailure()
        }
        data[newData.id] = newData
        updatePublisher.accept(())
    }

    func invalidReasons() -> [String] {
        return data.flatMap { $0.value.invalidReasons() }
    }
}

