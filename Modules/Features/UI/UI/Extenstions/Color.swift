//
//  Color.swift
//  UI
//
//  Created by Jonatan Ortiz on 07/08/23.
//

import SwiftUI

public extension Color {
    static var primaryColor: Self { Color(Colors.primaryColor.rawValue, bundle: Bundle.ui) }
    static var primaryReverse: Self { Color(Colors.primaryReverse.rawValue, bundle: Bundle.ui) }
    static var appPurple: Self { Color(Colors.appPurple.rawValue, bundle: Bundle.ui) }
    static var appBlue: Self { Color(Colors.appBlue.rawValue, bundle: Bundle.ui) }
    static var darkPurple: Self { Color(Colors.darkPurple.rawValue, bundle: Bundle.ui) }
}
