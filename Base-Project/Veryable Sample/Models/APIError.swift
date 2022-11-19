//
//  APIError.swift
//  Veryable Sample
//
//  Created by Nikhil Khandelwal on 11/16/22.
//  Copyright © 2022 Veryable Inc. All rights reserved.
//

import Foundation

enum APIError: Error {
    case urlNotValid
    case responseFailed
    
    var localizedDescription: String {
        switch self {
        case .responseFailed: return "The response failed with code"
        case .urlNotValid: return "URL was not valid"
        }
    }
}
