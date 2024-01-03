//
//  DependencyContainerMock.swift
//  HomeTests
//
//  Created by Jonatan Ortiz on 16/10/23.
//

import CoreInterface

typealias HomeDependencies = HasAuthentication & HasAnalytics

final class DependencyContainerMock: HomeDependencies {
    lazy var auth: Authenticating = resolve()
    lazy var analytics: AnalyticsProtocol = resolve()
    
    private let dependencies: [Any]

    init(_ dependencies: Any...) {
        self.dependencies = dependencies
    }
}

extension DependencyContainerMock {
    func resolve<T>() -> T {
        let resolved = dependencies.compactMap { $0 as? T }

        switch resolved.first {
        case .none:
            fatalError("DependencyContainerMock could not resolve dependency: \(T.self)\n")
        case .some where resolved.count > 1:
            fatalError("DependencyContainerMock resolved multiple dependencies for: \(T.self)\n")
        case .some(let mock):
            return mock
        }
    }
}
