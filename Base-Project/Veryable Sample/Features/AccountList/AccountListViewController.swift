//
//  AccountListViewController.swift
//  Veryable Sample
//
//  Created by Isaac Sheets on 5/27/21.
//  Copyright © 2021 Veryable Inc. All rights reserved.
//

import Foundation
import UIKit

class AccountListViewController: UIViewController {
    //MARK: Public API

    //MARK: Inits
    init() {
        super.init(nibName: nil, bundle: nil)
        self.title = "Accounts".uppercased()
    }
    required init?(coder: NSCoder) { nil }

    //MARK: Overrides
    override func loadView() {
        view = accountListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = VGrey.dark.color
    }

    //MARK: Private members

    //MARK: Lazy Loads
    private lazy var accountListView: AccountListView = {
        AccountListView(delegate: self)
    }()
    
    func showAlertViewController() {
        let alert = UIAlertController(
            title: "Could not load account information",
            message: "Unable to load account information. Please try again after sometime.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { _ in }))
        present(alert, animated: true)
    }
}

extension AccountListViewController: AccountListDelegate {
    func rowSelectedModel(model: AccountInfoViewModel) {
        let acctDetailVC = AccountDetailViewController(withInfoModel: model)
        navigationController?.pushViewController(acctDetailVC, animated: true)
    }
    
    func failedToReceiveAccountInfo() {
        showAlertViewController()
    }
}
