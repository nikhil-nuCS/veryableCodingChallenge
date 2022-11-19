//
//  AccountDetailViewController.swift
//  Veryable Sample
//
//  Created by Nikhil Khandelwal on 11/17/22.
//  Copyright © 2022 Veryable Inc. All rights reserved.
//

import Foundation
import SnapKit
import UIKit

class AccountDetailViewController: UIViewController {

    //MARK: Public API
    var accountInfoVM: AccountInfoViewModel?
    
    //MARK: Inits
    init(withInfoModel: AccountInfoViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.accountInfoVM = withInfoModel
        self.title = "Details".uppercased()
    }
    required init?(coder: NSCoder) { nil }

    //MARK: Overrides
    override func loadView() {
        view = acctDetailView
    }
        
    //MARK: Lazy Loads
    private lazy var acctDetailView: AccountDetailView = {
        let view = AccountDetailView(delegate: self, viewModel: accountInfoVM)
        return view
    }()
}

extension AccountDetailViewController: AccountDetailDelegate {
    func doneButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
}
