//
//  AccountInfo.swift
//  Veryable Sample
//
//  Created by Nikhil Khandelwal on 11/18/22.
//  Copyright © 2022 Veryable Inc. All rights reserved.
//

import Foundation
import UIKit

protocol AccountInfo {
    var id: Int { get set }
    var type: AccountType { get set }
    var name: String { get set }
    var description: String { get set }
}

struct AccountInfoViewModel: AccountInfo {
    var id: Int
    var type: AccountType
    var name: String
    var description: String
    
    var uiIcon: UIImage? {
        switch type {
        case .bank:
            return UIImage(named: "bank")?.withRenderingMode(.alwaysTemplate)
        case .card:
            return UIImage(named: "card")?.withRenderingMode(.alwaysTemplate)
        }
    }
    
    var transactionType: String {
        switch type {
        case .bank:
            return "Bank Account: ACH - Same Day"
        case .card:
            return "Card: Instant"
        }
    }
    
    init(fromModel: Account) {
        self.id = fromModel.id
        self.type = fromModel.accountType
        self.name = fromModel.accountName
        self.description = fromModel.desc
    }
}
