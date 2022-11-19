//
//  AccountService.swift
//  Veryable Sample
//
//  Created by Nikhil Khandelwal on 11/16/22.
//  Copyright © 2022 Veryable Inc. All rights reserved.
//

import Foundation
import Combine

class AccountService: CombineAPI {
    
    var session: URLSession    
    var accounts : [AccountInfoViewModel] = []
    
    let sections = AccountType.allCases.map { $0.rawValue }
    
    lazy var accountServiceJsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    let urlString = "https://veryable-public-assets.s3.us-east-2.amazonaws.com/veryable.json"
        
    init(urlSessionConfig: URLSessionConfiguration) {
        self.session = URLSession(configuration: urlSessionConfig)
        session.configuration.requestCachePolicy = .reloadRevalidatingCacheData
    }
    
    convenience init() {
        self.init(urlSessionConfig: .default)
    }
    
    func fetchAccountsInformation() -> AnyPublisher<[AccountInfoViewModel],Error> {
        guard let url = URL(string: urlString) else {
            return Fail(error: APIError.urlNotValid)
                .eraseToAnyPublisher()
        }
        return execute(url: url, retryCount: 3)
            .receive(on: DispatchQueue.main)
            .decode(type: [Account].self, decoder: accountServiceJsonDecoder)
            .map { $0.map(AccountInfoViewModel.init) }
            .eraseToAnyPublisher()
    }
}
