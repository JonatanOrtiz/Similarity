//
//  AnalyticsProtocol.swift
//  CoreInterface
//
//  Created by Jonatan Ortiz on 16/10/23.
//

public protocol HasAnalytics {
    var analytics: AnalyticsProtocol { get }
}

public protocol ThirdPartyTracker {
    func track(_ event: String, properties: [String: Any])
}

public protocol ThirdPartyIdentifiable {
    func identify()
}

public protocol AnalyticsProtocol: AnyObject {
    func identify()
    func log(_ eventKey: AnalyticsKeyProtocol)
    func register(tracker: ThirdPartyTracker, for provider: AnalyticsProvider)
}

public extension AnalyticsProtocol {
    func register(tracker: ThirdPartyTracker, for provider: AnalyticsProvider) {
        register(tracker: tracker, for: provider)
    }
}
