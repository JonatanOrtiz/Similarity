//
//  DependencyOrchestrator.swift
//  HomeSample
//
//  Created by Jonatan Ortiz on 02/01/24.
//

import Core
import CoreInterface

enum DependencyOrchestrator {
    static func start() {
        FirebaseConfigure.firebaseConfigure()

        @Provider var auth: Authenticating = AuthRepository.shared
        @Provider var analytics: AnalyticsProtocol = AnalyticsRepository.shared
    }
}
