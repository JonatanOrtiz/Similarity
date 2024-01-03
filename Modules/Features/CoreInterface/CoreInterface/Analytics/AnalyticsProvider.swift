//
//  AnalyticsProvider.swift
//  CoreInterface
//
//  Created by Jonatan Ortiz on 16/10/23.
//

@objc
public enum AnalyticsProvider: Int, CaseIterable, CustomStringConvertible {
    case firebase = 0

    public var description: String {
        switch self {
        case .firebase:
            return "firebase"
        }
    }
}
