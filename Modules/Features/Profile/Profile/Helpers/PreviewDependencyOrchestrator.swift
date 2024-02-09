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
        @Provider var profiling: Profiling = ProfilingMock()
        @Provider var analytics: AnalyticsProtocol = AnalyticsMock.fixture()
    }
}
