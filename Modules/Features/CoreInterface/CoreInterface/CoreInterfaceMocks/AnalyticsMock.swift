//
//  AnalyticsMock.swift
//  CoreInterface
//
//  Created by Jonatan Ortiz on 16/10/23.
//

public final class AnalyticsMock: AnalyticsProtocol {
    var identifyImpl: () -> Void = { fatalError("not implemented") }
    var logImpl: (AnalyticsKeyProtocol) -> Void = { _ in fatalError("not implemented") }
    var registerImpl: (ThirdPartyTracker, AnalyticsProvider) -> Void = { _, _ in fatalError("not implemented") }

    public static func fixture(
        identify: @escaping () -> Void = { fatalError("not implemented") },
        log: @escaping (AnalyticsKeyProtocol) -> Void = { _ in fatalError("not implemented") },
        register: @escaping (ThirdPartyTracker, AnalyticsProvider) -> Void = { _, _ in fatalError("not implemented") }
    ) -> AnalyticsMock {
        let mock = AnalyticsMock()
        mock.identifyImpl = identify
        mock.logImpl = log
        mock.registerImpl = register
        return mock
    }

    public func identify() {
        identifyImpl()
    }

    public func log(_ eventKey: AnalyticsKeyProtocol) {
        logImpl(eventKey)
    }

    public func register(tracker: ThirdPartyTracker, for provider: AnalyticsProvider) {
        registerImpl(tracker, provider)
    }
}
