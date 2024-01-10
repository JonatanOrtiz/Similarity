//
//  Color.swift
//  UI
//
//  Created by Jonatan Ortiz on 07/08/23.
//

import SwiftUI

// MARK: - App Colors
public extension Color {
    static var primaryColor: Self { Color(Colors.primaryColor.rawValue, bundle: Bundle.ui) }
    static var primaryReverse: Self { Color(Colors.primaryReverse.rawValue, bundle: Bundle.ui) }
    static var appPurple: Self { Color(Colors.appPurple.rawValue, bundle: Bundle.ui) }
    static var appBlue: Self { Color(Colors.appBlue.rawValue, bundle: Bundle.ui) }
    static var darkPurple: Self { Color(Colors.darkPurple.rawValue, bundle: Bundle.ui) }
    static var primaryPurple: Self { Color(Colors.primaryPurple.rawValue, bundle: Bundle.ui) }
    static var appBackground: Self { Color(Colors.appBackground.rawValue, bundle: Bundle.ui) }
    static var appWhite: Self { Color(Colors.appWhite.rawValue, bundle: Bundle.ui) }
}

// MARK: - Hexa To RGB
public extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
            case 3:
                (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
            case 6:
                (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
            case 8:
                (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
            default:
                (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(.sRGB, red: Double(r) / 255, green: Double(g) / 255, blue:  Double(b) / 255, opacity: Double(a) / 255)
    }
}
