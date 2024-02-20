//
//  DependencyOrchestrator.swift
//  Similarity
//
//  Created by Jonatan Ortiz on 30/09/23.
//

import Core
import CoreInterface

enum DependencyOrchestrator {
    static func start() {
        @Provider var auth: Authenticating = AuthRepository.shared
        @Provider var analytics: AnalyticsProtocol = AnalyticsRepository.shared
        @Provider var dataManagement: DataManaging = DataManagementRepository.shared
    }
}
