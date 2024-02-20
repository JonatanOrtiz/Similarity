//
//  ApiMock.swift
//  CoreInterface
//
//  Created by Jonatan Ortiz on 19/02/24.
//

import Combine

public enum DataManagingError: Error {
    case mockNotSetUp
}

public final class DataManagementMock: DataManaging {
    private var fetchResults: [String: Any] = [:]
    private var saveResults: [String: Any] = [:]
    private var updateResults: [String: Any] = [:]
    private var deleteResults: [String: Any] = [:]

    public init() {}

    public func execute<T>(
        operation: DataServiceOperation,
        configuration: DataServiceConfiguration
    ) -> AnyPublisher<T, Error> where T: Decodable, T: Encodable {
        switch operation {
            case .fetch:
                if let result = fetchResults[String(describing: T.self)] as? Result<T, Error> {
                    return result.publisher.eraseToAnyPublisher()
                }
            case .save:
                if let result = saveResults[String(describing: T.self)] as? Result<T, Error> {
                    return result.publisher.eraseToAnyPublisher()
                }
            case .update:
                if let result = updateResults[String(describing: T.self)] as? Result<T, Error> {
                    return result.publisher.eraseToAnyPublisher()
                }
            case .delete:
                if let result = deleteResults[String(describing: T.self)] as? Result<T, Error> {
                    return result.publisher.eraseToAnyPublisher()
                }
        }
        return Fail(error: DataManagingError.mockNotSetUp).eraseToAnyPublisher()
    }

    public func setFetchResult<T: Decodable & Encodable>(_ result: Result<T, Error>, forType type: T.Type) {
        fetchResults[String(describing: type)] = result
    }

    public func setSaveResult<T: Decodable & Encodable>(_ result: Result<T, Error>, forType type: T.Type) {
        saveResults[String(describing: type)] = result
    }

    public func setUpdateResult<T: Decodable & Encodable>(_ result: Result<T, Error>, forType type: T.Type) {
        updateResults[String(describing: type)] = result
    }

    public func setDeleteResult<T: Decodable & Encodable>(_ result: Result<T, Error>, forType type: T.Type) {
        deleteResults[String(describing: type)] = result
    }
}
