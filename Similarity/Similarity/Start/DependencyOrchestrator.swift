//
//  DependencyOrchestrator.swift
//  Similarity
//
//  Created by Jonatan Ortiz on 30/09/23.
//

import Core
import CoreInterface

struct DependencyOrchestrator {
    static func start() {
        @Provider var auth: Authenticating = AuthRepository.shared
        @Provider var analytics: AnalyticsProtocol = AnalyticsRepository.shared
    }
}
