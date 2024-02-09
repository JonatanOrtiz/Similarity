//
//  AnalyticsEvent.swift
//  CoreInterface
//
//  Created by Jonatan Ortiz on 16/10/23.
//

public struct AnalyticsEvent: AnalyticsEventProtocol, AnalyticsKeyProtocol {
    public let name: String
    public let properties: [String: Any]
    public let providers: [AnalyticsProvider]

    public init(
        _ name: String,
        properties: [String: Any] = [:],
        providers: [AnalyticsProvider] = [.firebase]
    ) {
        self.name = name
        self.properties = properties
        self.providers = providers
    }

    public func event() -> AnalyticsEventProtocol { self }
}

// MARK: Codable
extension AnalyticsEvent: Codable {
    enum CodingKeys: String, CodingKey {
        case eventName = "event_name"
        case properties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .eventName)
        properties = try container.decode([String: Any].self, forKey: .properties)
        providers = [.firebase]
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .eventName)
        try container.encode(AnyCodable(value: properties), forKey: .properties)
    }

    public var screenName: String? {
        properties["screen_name"] as? String
    }

    public var dialogName: String? {
        properties["dialog_name"] as? String
    }
}
