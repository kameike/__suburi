//
//  ViewController.swift
//  testProject
//
//  Created by Kei Kameda on 2018/11/10.
//  Copyright © 2018年 Kei Kameda. All rights reserved.
//

import UIKit
import DataSourceKit
import RxSwift

class FormDeclarator: CellsDeclarator {
    func declareCells(_ cell: (CellDeclaration) -> Void) {
        for d in bloc.data.values {
            cell(.data(data: d, bloc: bloc))
        }

        if !bloc.valid {
            var invalidReason = ""
            for b in bloc.invalidReasons() {
                invalidReason =  invalidReason + "\n" + b
            }
            cell(.notSatisfy(reason: invalidReason))
        }
        cell(.submitButton(isReady: bloc.valid))
    }

    enum CellDeclaration {
        case data(data: FormData, bloc: FormBusinessLogicContainer)
        case notSatisfy(reason: String)
        case submitButton(isReady: Bool)
    }
    var bloc: FormBusinessLogicContainer!
}

class FormViewController: UIViewController {
    static func viewController(data: [FormData]) -> FormViewController {
        guard let vc = R.storyboard.form().instantiateInitialViewController() as? FormViewController else {
            fatalError()
        }

        vc.formBloc = FormBusinessLogicContainer(formData: data)

        return vc
    }

    let datasource = TableViewDataSource<FormDeclarator.CellDeclaration> { decratator in
        switch decratator {
        case .data(let data):
            return FormCell.makeBinder(value: data)
        case .submitButton(let isReady):
            return OkButtonCell.makeBinder(value: isReady)
        case .notSatisfy(let reason):
            return NotSatisfyCell.makeBinder(value: reason)
        }
    }

    @IBOutlet weak var ok: UILabel!
    @IBOutlet weak var reason: UILabel!
    let declarator = FormDeclarator()
    let bag = DisposeBag()
    var formBloc: FormBusinessLogicContainer!

    @IBOutlet weak var tabelView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tabelView.separatorStyle = .none

        declarator.bloc = formBloc
        tabelView.dataSource = datasource

        formBloc.updatePublisher
            .bind(onNext: reloadTable)
            .disposed(by: bag)

        reloadTable()
    }

    private func reloadTable() {
        datasource.cellDeclarations = declarator.cellDeclarations
        tabelView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

