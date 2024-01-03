//
//  AnalyticsSpy.swift
//  CoreInterface
//
//  Created by Jonatan Ortiz on 17/10/23.
//

import Foundation

public final class AnalyticsSpy: AnalyticsProtocol {
    public private(set) var event: EquatableAnalyticsEvent? {
        didSet {
            guard let event = event else { return }
            events.append(event)
        }
    }
    
    public private(set) var events: [EquatableAnalyticsEvent] = []
    
    public private(set) var logCalledCount = 0
    public private(set) var identifyCalledCount = 0
    public private(set) var registerCalledCount = 0

    public init() {}

    public func log(_ event: AnalyticsKeyProtocol) {
        self.event = event.equatableEvent()
        self.logCalledCount += 1
    }

    public func register(tracker: ThirdPartyTracker, for: AnalyticsProvider) {
        registerCalledCount += 1
    }

    public func identify() {
        identifyCalledCount += 1
    }

    public func equals(to: AnalyticsEventProtocol) -> Bool {
        guard let event = event else {
            return false
        }
        return compare(first: event, second: to)
    }

    public func equals(to event: AnalyticsEventProtocol...) -> Bool {
        events.elementsEqual(event, by: compare(first:second:))
    }

    public func value(forKey key: String) -> String? {
        guard let value = event?.properties[key] else {
            return nil
        }

        return "\(value)"
    }

    private func compare(first: AnalyticsEventProtocol, second: AnalyticsEventProtocol) -> Bool {
        first.name == second.name &&
            NSDictionary(dictionary: first.properties).isEqual(to: second.properties) &&
            first.providers == second.providers
    }
}

public struct EquatableAnalyticsEvent: AnalyticsEventProtocol, Equatable {
    public var name: String
    public var properties: [String: Any]
    public var providers: [AnalyticsProvider]

    public init(_ event: AnalyticsEventProtocol) {
        name = event.name
        properties = event.properties
        providers = event.providers
    }

    public static func == (lhs: EquatableAnalyticsEvent, rhs: EquatableAnalyticsEvent) -> Bool {
        lhs.name == rhs.name &&
        NSDictionary(dictionary: lhs.properties).isEqual(to: rhs.properties) &&
        lhs.providers == rhs.providers
    }
}

public extension AnalyticsKeyProtocol {
    func equatableEvent() -> EquatableAnalyticsEvent {
        EquatableAnalyticsEvent(event())
    }
}
