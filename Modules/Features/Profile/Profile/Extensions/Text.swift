//
//  Text.swift
//  Profile
//
//  Created by Jonatan Ortiz on 17/08/23.
//

import SwiftUI
import UI

public extension Text {
    static func localized(_ key: LocalizedStringKey) -> Self {
        return Text(key, tableName: "Localizable", bundle: .profile)
    }
}
