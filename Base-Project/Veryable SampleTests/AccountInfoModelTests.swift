//
//  AccountInfoModelTests.swift
//  Veryable SampleTests
//
//  Created by Nikhil Khandelwal on 11/18/22.
//  Copyright © 2022 Veryable Inc. All rights reserved.
//

import XCTest

final class AccountInfoModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAccountInfoModelWithValidData() throws {
        let sampleAcct = Account(id: 102, accountType: .bank, accountName: "Test Account", desc: "Test Description")
        let sampleAcctModel = AccountInfoViewModel(fromModel: sampleAcct)
        
        XCTAssertEqual(sampleAcctModel.name, "Test Account")
        XCTAssertEqual(sampleAcctModel.type, .bank)
        XCTAssertEqual(sampleAcctModel.description, "Test Description")
        XCTAssertNotNil(sampleAcctModel.uiIcon)
    }
}
