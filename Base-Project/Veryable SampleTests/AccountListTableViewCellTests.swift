//
//  AccountListTableViewCellTests.swift
//  Veryable SampleTests
//
//  Created by Nikhil Khandelwal on 11/18/22.
//  Copyright © 2022 Veryable Inc. All rights reserved.
//

import XCTest

final class AccountListTableViewCellTests: XCTestCase {

    var tableViewCell: AccountListTableViewCell?
    override func setUpWithError() throws {
        tableViewCell = AccountListTableViewCell()
    }

    override func tearDownWithError() throws {
        tableViewCell = nil
    }
    
    func testCellConfiguration() throws {
        XCTAssertEqual(tableViewCell?.contentView.subviews.count, 2)
    }

    func testAccountTitleFormat() throws {
        XCTAssertEqual(tableViewCell?.acctNameLabel.font, .vryAvenirNextDemiBold(14))
        XCTAssertEqual(tableViewCell?.acctNameLabel.textColor, VGrey.dark.color)
    }
    
    func testAccountDescriptionFormat() throws {
        XCTAssertEqual(tableViewCell?.acctDescriptionLabel.font, .vryAvenirNextRegular(12))
        XCTAssertEqual(tableViewCell?.acctDescriptionLabel.textColor, VGrey.dark.color)
    }
    
    func testAccountPaymentFormat() throws {
        XCTAssertEqual(tableViewCell?.acctTransactionTypeLabel.font, .vryAvenirNextRegular(12))
        XCTAssertEqual(tableViewCell?.acctTransactionTypeLabel.textColor, VGrey.normal.color)
    }
    
    func testAccountCellStackView() throws {
        XCTAssertEqual(tableViewCell?.detailsStackView.arrangedSubviews.count, 3)
    }
    
    func testCellSetupWithData() throws {
        let accountInfoModel = AccountInfoViewModel(
            fromModel: Account(
                id: 100,
                accountType: .card,
                accountName: "TST VBank Saving",
                desc: "VBank (x1000)"
            )
        )
        tableViewCell?.configureCell(acctModel: accountInfoModel)
        XCTAssertEqual(tableViewCell?.acctNameLabel.text, "TST VBank Saving")
        XCTAssertEqual(tableViewCell?.acctDescriptionLabel.text, "VBank (x1000)")
        XCTAssertEqual(tableViewCell?.acctTransactionTypeLabel.text, "Card: Instant")
    }
}
