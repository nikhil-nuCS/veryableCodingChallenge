//
//  CombineAPI.swift
//  Veryable Sample
//
//  Created by Nikhil Khandelwal on 11/16/22.
//  Copyright © 2022 Veryable Inc. All rights reserved.
//

import Foundation
import Combine

protocol CombineAPI {
    var session: URLSession { get }
    func execute(url: URL, retryCount: Int) -> AnyPublisher<Data,Error>
}

extension CombineAPI {
    func execute(url: URL, retryCount: Int = 2) -> AnyPublisher<Data,Error> {
        return session.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .tryMap {
                guard let response = $0.response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw APIError.responseFailed
                }
                return $0.data
            }
            .retry(retryCount)
            .eraseToAnyPublisher()
    }
}
