//
//  DataManagementRepository.swift
//  Core
//
//  Created by Jonatan Ortiz on 19/02/24.
//

import Combine
import CoreInterface

public final class DataManagementRepository: DataManaging {
    public static let shared: DataManaging = DataManagementRepository()

    public init() {}

    public func execute<T>(
        operation: DataServiceOperation,
        configuration: DataServiceConfiguration
    ) -> AnyPublisher<T, Error> where T: Decodable, T: Encodable {
        if let firestoreConfig = configuration as? DocumentDatabaseConfiguration {
            return FirestoreDataService.execute(operation: operation, configuration: firestoreConfig)
                .eraseToAnyPublisher()
        } else if let httpConfiguration = configuration as? HTTPRequestConfiguration {
            return HTTPRequestService.execute(with: httpConfiguration)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: CustomError(title: Strings.DataManagementError.unsupportedConfiguration))
                .eraseToAnyPublisher()
        }
    }
}
