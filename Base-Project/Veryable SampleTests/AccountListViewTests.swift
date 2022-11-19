//
//  AccountListViewTests.swift
//  Veryable SampleTests
//
//  Created by Nikhil Khandelwal on 11/18/22.
//  Copyright © 2022 Veryable Inc. All rights reserved.
//

import XCTest
import Combine

final class AccountListViewTests: XCTestCase, AccountListDelegate {
    var view: MockAccountListView?

    override func setUpWithError() throws {
        view = MockAccountListView(delegate: self)
        view?.accountService = MockAccountService()
    }

    override func tearDownWithError() throws {
        view = nil
    }
    
    func testUpdateViewWithModel() {
        let data = [
            AccountInfoViewModel(fromModel: Account(
                id: 100,
                accountType: .bank,
                accountName: "TST VR Bank",
                desc: "TST Savings Account")
            )
        ]
        view?.updateWithAccountData(withData: data)
        guard let view = view else {
            return
        }
        XCTAssertTrue(view.updateViewWithModelCalled)
        XCTAssertEqual(view.tableSectionModel.count, 2)
    }
    
    func rowSelectedModel(model: AccountInfoViewModel) {
    }
    
    func failedToReceiveAccountInfo() {
    }

}


class MockAccountListView: AccountListView {
    var updateViewWithModelCalled = false
    
    override init(delegate: AccountListDelegate) {
        super.init(delegate: delegate)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateWithAccountData(withData: [AccountInfoViewModel]) {
        super.updateWithAccountData(withData: withData)
        updateViewWithModelCalled = true
    }
}
