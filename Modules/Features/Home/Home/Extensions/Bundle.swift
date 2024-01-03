//
//  Bundle.swift
//  Home
//
//  Created by Jonatan Ortiz on 20/10/23.
//

import SwiftUI

class HomeBundleIdentifierClass {}

public extension Bundle {
    static var home: Bundle {
        guard let bundleIdentifier = Bundle(for: HomeBundleIdentifierClass.self)
            .infoDictionary?[kCFBundleIdentifierKey as String] as? String
        else { return Bundle.main }
        return Bundle(identifier: bundleIdentifier) ?? Bundle.main
    }
}
