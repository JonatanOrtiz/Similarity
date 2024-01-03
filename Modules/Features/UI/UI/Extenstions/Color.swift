//
//  Color.swift
//  UI
//
//  Created by Jonatan Ortiz on 07/08/23.
//

import SwiftUI

public extension Color {
    static var primary: Self {
        return Color(Colors.primary.rawValue, bundle: Bundle.ui)
    }
    
    static var primaryReverse: Self {
        return Color(Colors.primaryReverse.rawValue, bundle: Bundle.ui)
    }
    
    static var appPurple: Self {
        return Color(Colors.appPurple.rawValue, bundle: Bundle.ui)
    }
}
