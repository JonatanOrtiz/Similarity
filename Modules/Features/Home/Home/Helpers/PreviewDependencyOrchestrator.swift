//
//  PreviewDependencyOrchestrator.swift
//  Home
//
//  Created by Jonatan Ortiz on 03/01/24.
//

import Core
import CoreInterface

enum PreviewDependencyOrchestrator {
    static func start() {
        @Provider var auth: Authenticating = AuthenticationMock<Any>()
        @Provider var analytics: AnalyticsProtocol = AnalyticsMock.fixture()
    }
}
