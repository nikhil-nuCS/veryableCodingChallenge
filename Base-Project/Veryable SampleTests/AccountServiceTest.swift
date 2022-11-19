//
//  AccountServiceTest.swift
//  Veryable SampleTests
//
//  Created by Nikhil Khandelwal on 11/18/22.
//  Copyright © 2022 Veryable Inc. All rights reserved.
//

import XCTest
import Combine

final class AccountServiceTest: XCTestCase {
    
    var accountService: AccountService?

    override func setUpWithError() throws {
        accountService = MockAccountService()
    }

    override func tearDownWithError() throws {
        accountService = nil
    }

    func testAccountListURL() throws {
        XCTAssertEqual(accountService?.urlString, "https://veryable-public-assets.s3.us-east-2.amazonaws.com/veryable.json")
    }
    
    func testURLSessionConfiguration() throws {
        let configSession = accountService?.session.configuration
        XCTAssertNotNil(accountService?.session)
        XCTAssertEqual(configSession, .default)
        XCTAssertEqual(configSession?.requestCachePolicy.rawValue, 0)
    }
    
    func testJSONDecoder() throws {
        XCTAssertNotNil(accountService?.accountServiceJsonDecoder)
    }
    
    func testFetchAccountInformation() throws {
        let cancellable = accountService?.fetchAccountsInformation()
            .sink(receiveCompletion: { _ in }, receiveValue: { list in
                XCTAssertEqual(list.count, 1)
                XCTAssertEqual(list[0].type, .card)
                XCTAssertEqual(list[0].id, 100)
                XCTAssertEqual(list[0].name, "TST VBank Card")
                XCTAssertEqual(list[0].description, "Credit Card")
            })
    }
}

class MockAccountService: AccountService {
    override func fetchAccountsInformation() -> AnyPublisher<[AccountInfoViewModel], Error> {
        let mockResult = Account(
            id: 100,
            accountType: .card,
            accountName: "TST VBank Card",
            desc: "Credit Card")
        let mockInfo = AccountInfoViewModel(fromModel: mockResult)
        return Just([mockInfo])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

