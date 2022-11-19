//
//  Account.swift
//  Veryable Sample
//
//  Created by Isaac Sheets on 5/27/21.
//  Copyright © 2021 Veryable Inc. All rights reserved.
//

import Foundation

struct Account: Decodable {
    var id: Int
    var accountType: AccountType
    var accountName: String
    var desc: String
}

enum AccountType: String, Codable, CaseIterable {
    case bank = "bank"
    case card = "card"
}
