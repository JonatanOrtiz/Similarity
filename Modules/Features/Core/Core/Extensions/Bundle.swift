//
//  Bundle.swift
//  Core
//
//  Created by Jonatan Ortiz on 19/10/23.
//

class CoreBundleIdentifierClass {}

public extension Bundle {
    static var core: Bundle {
        guard let bundleIdentifier = Bundle(for: CoreBundleIdentifierClass.self)
            .infoDictionary?[kCFBundleIdentifierKey as String] as? String
        else { return Bundle.main }
        return Bundle(identifier: bundleIdentifier) ?? Bundle.main
    }
}
