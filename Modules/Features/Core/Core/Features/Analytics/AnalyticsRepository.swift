//
//  AnalyticsRepository.swift
//  Core
//
//  Created by Jonatan Ortiz on 16/10/23.
//

import CoreInterface

public final class AnalyticsRepository: AnalyticsProtocol {
    private let syncQueue = DispatchQueue(label: "com.similarity.concurrent.tracking.analytics", attributes: .concurrent)
    private var trackers: [AnalyticsProvider: ThirdPartyTracker] = [:]
    private var redirects: [AnalyticsProvider: AnalyticsProvider] = [:]

    public static let shared: AnalyticsProtocol = AnalyticsRepository()

    private init() { }

    public func register(tracker: ThirdPartyTracker, for provider: AnalyticsProvider) {
        // lock on write preventing other threads from modifying the collection.
        syncQueue.async(flags: .barrier) { [weak self] in
            guard let self = self else { return }
            self.trackers[provider] = tracker
        }
    }

    public func identify() {
        syncQueue.sync {
            trackers.values.lazy
                .compactMap { $0 as? ThirdPartyIdentifiable }
                .forEach { $0.identify() }
        }
    }

    public func log(_ eventKey: AnalyticsKeyProtocol) {
        let event = eventKey.event()
        let trackers = syncQueue.sync { self.trackers }

        for provider in applyProviderRedirections(to: event.providers) {
            guard let tracker = trackers[provider] else { continue }

            tracker.track(event.name, properties: event.properties)
        }
    }

    private func applyProviderRedirections(to providers: [AnalyticsProvider]) -> [AnalyticsProvider] {
        // For-in is not thread safe and mutating the underlying collection can cause an exception,
        // so we safely crate a local copy to work on.
        let storedRedirects = syncQueue.sync { self.redirects }
        var fixedProviders = Set(providers)

        for (sourceProvider, targetProvider) in storedRedirects {
            if fixedProviders.remove(sourceProvider) != nil {
                fixedProviders.insert(targetProvider)
            }
        }
        return .init(fixedProviders)
    }
}
