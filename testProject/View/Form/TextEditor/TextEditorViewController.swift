//
//  File.swift
//  testProject
//
//  Created by Kei Kameda on 2018/11/10.
//  Copyright © 2018年 Kei Kameda. All rights reserved.
//

import UIKit
import RxSwift

protocol UpdateTextDelegate: class {
    func updateText(_ newPayload: PayloadText)
}

class TextEditorViewConroller: UIViewController {
    static func viewController(for payload: PayloadText) -> TextEditorViewConroller {
        guard let vc = R.storyboard.textEditor().instantiateInitialViewController() as? TextEditorViewConroller else {
            fatalError()
        }

        let viewModel = TextEditViewModel(payload: payload)
        vc.viewModel = viewModel

        return vc
    }

    var delegate: UpdateTextDelegate? {
        get {
            return viewModel.delegate
        }
        set(d) {
            viewModel.delegate = d
        }
    }

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var warning: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    private var viewModel: TextEditViewModel!

    @IBOutlet weak var form: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var reason: UILabel!
    @IBOutlet weak var completeButton: UIButton!
    

    private let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        form.text = viewModel.payload.text

        form.rx.text.asObservable()
            .flatMap { query -> Observable<String> in
                if let query = query {
                    return Observable.just(query)
                }
                return .empty()
            }
            .bind(to: viewModel.query)
            .disposed(by: bag)

        titleLabel.text = viewModel.payload.description

        doneButton.rx.tap.asObservable()
            .bind(onNext: dismiss)
            .disposed(by: bag)

        viewModel.validRelay
            .bind(to: completeButton.rx.isEnabled)
            .disposed(by: bag)

        viewModel.invalidReasonRelay
            .bind(to: reason.rx.text)
            .disposed(by: bag)
    }

    private func dismiss() {
        viewModel.updateBloc()
        dismiss(animated: true, completion: nil)
    }
}
