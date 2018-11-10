//
//  MainViewController.swift
//  testProject
//
//  Created by Kei Kameda on 2018/11/11.
//  Copyright © 2018年 Kei Kameda. All rights reserved.
//

import UIKit
import DataSourceKit

class MainDeclarator: CellsDeclarator {
    let forms: [[FormData]]

    init(forms: [[FormData]]) {
        self.forms = forms
    }

    func declareCells(_ cell: (CellDeclaration) -> Void) {
        for form in forms {
            cell(.toForm(form))
        }
    }

    enum CellDeclaration {
        case toForm([FormData])
    }
}

class MainViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    var declarator = MainDeclarator(forms: [
        FormDataCreator().createFormData(),
        FormDataCreator().createLongFormData(),
        FormDataCreator().createShortFormData(),
        FormDataCreator().createFormData(),
    ])

    let datasource = TableViewDataSource<MainDeclarator.CellDeclaration> { target in
        switch target {
        case .toForm(let formData):
            return MainCell.makeBinder(value: formData)
        }
    }

    override func viewDidLoad() {
        tableView.dataSource = datasource
        datasource.cellDeclarations = declarator.cellDeclarations
        tableView.reloadData()
    }
}
