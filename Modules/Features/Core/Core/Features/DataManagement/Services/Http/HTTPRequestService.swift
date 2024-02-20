//
//  HTTPRequestService.swift
//  Core
//
//  Created by Jonatan Ortiz on 19/02/24.
//

import Combine
import Foundation
import CoreInterface

class HTTPRequestService {
    static func execute<T: Decodable>(
        with configuration: HTTPRequestConfiguration
    ) -> AnyPublisher<T, Error> {
        var request = URLRequest(url: configuration.url)
        request.httpMethod = configuration.method.rawValue
        request.httpBody = configuration.body
        configuration.headers.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }

        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { result in
                guard let response = result.response as? HTTPURLResponse,
                      (200...299).contains(response.statusCode) else {
                    throw URLError(.badServerResponse)
                }
                return result.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
