//
//  DataManagement.swift
//  CoreInterface
//
//  Created by Jonatan Ortiz on 19/02/24.
//

import Combine

public protocol HasDataManagement {
    var dataManagement: DataManaging { get }
}

public protocol DataManaging {
    func execute<T: Codable>(operation: DataServiceOperation, configuration: DataServiceConfiguration) -> AnyPublisher<T, Error>
}

public enum DataServiceOperation {
    case fetch
    case save
    case update
    case delete
}

public protocol DataServiceConfiguration {}
