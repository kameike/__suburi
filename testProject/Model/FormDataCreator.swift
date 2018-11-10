//
//  FormDataCreator.swift
//  testProject
//
//  Created by Kei Kameda on 2018/11/10.
//  Copyright © 2018年 Kei Kameda. All rights reserved.
//

import Foundation

class FormDataCreator {
    func createFormData() -> [FormData] {
        return [
            createName(),
            createAddress(),
            createMotivation(),
            createNumbered(),
            createNumbered(),
            createNumbered(),
            createNumbered(),
        ]
    }


    func createShortFormData() -> [FormData] {
        return [
            createName(),
        ]
    }

    func createLongFormData() -> [FormData] {
        return [
            createName(),
            createAddress(),
            createMotivation(),
            createNumbered(),
            createNumbered(),
            createNumbered(),
            createNumbered(),
            createNumbered(),
            createNumbered(),
            createNumbered(),
            createNumbered(),
            createNumbered(),
            createNumbered(),
            createNumbered(),
            createNumbered(),
            createNumbered(),
            createNumbered(),
            createNumbered(),
            createNumbered(),
            createNumbered(),
            createNumbered(),
            createNumbered(),
            createNumbered(),
            createNumbered(),
            createNumbered(),
            createNumbered(),
            createNumbered(),
            createNumbered(),
            createNumbered(),
            createNumbered(),
            createNumbered(),
            createNumbered(),
            createNumbered(),
            createNumbered(),
            createNumbered(),
        ]
    }


    func createName() -> FormData {
        let textPayload = PayloadText(
            validators: [TooLongTextValidator(maxCount: 40)], text: "", description: "氏名を入力してください")

        return FormData(
            requirement: .required,
            headerTitle: "氏名",
            payload: .text(textPayload),
            id: UUID().uuidString)
    }

    func createAddress() -> FormData {
        let textPayload = PayloadText(
            validators: [TooLongTextValidator(maxCount: 40)], text: "", description: "住所を入力してください")

        return FormData(
            requirement: .required,
            headerTitle: "住所",
            payload: .text(textPayload),
            id: UUID().uuidString)
    }

    func createMotivation() -> FormData {
        let textPayload = PayloadText(
            validators: [TooLongTextValidator(maxCount: 90)], text: "", description: "90文字でやる気を入力してください")

        return FormData(
            requirement: .optional,
            headerTitle: "やる気",
            payload: .text(textPayload),
            id: UUID().uuidString)
    }

    func createNumbered() -> FormData {
        let textPayload = PayloadText(
            validators: [NumericValidator()], text: "", description: "数字を入力してください")

        return FormData(
            requirement: .optional,
            headerTitle: "数字",
            payload: .text(textPayload),
            id: UUID().uuidString)
    }
}

