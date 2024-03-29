//
//  PreviewDependencyOrchestrator.swift
//  Profile
//
//  Created by Jonatan Ortiz on 08/02/24.
//

import Core
import CoreInterface

enum PreviewDependencyOrchestrator {
    static func start() {
        @Provider var auth: Authenticating = AuthenticationMock<Any>()
        @Provider var analytics: AnalyticsProtocol = AnalyticsMock.fixture()
        @Provider var dataManagement: DataManaging = DataManagementMock()
    }
}
