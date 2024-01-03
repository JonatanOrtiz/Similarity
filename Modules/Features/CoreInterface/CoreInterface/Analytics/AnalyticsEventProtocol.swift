//
//  AnalyticsEventProtocol.swift
//  CoreInterface
//
//  Created by Jonatan Ortiz on 16/10/23.
//

public protocol AnalyticsEventProtocol {
    var name: String { get }
    var properties: [String: Any] { get }
    var providers: [AnalyticsProvider] { get }
}

public extension AnalyticsEventProtocol {
    var providers: [AnalyticsProvider] { [.firebase] }
}
