//
//  Bundle.swift
//  UI
//
//  Created by Jonatan Ortiz on 07/08/23.
//

class UIBundleIdentifierClass {}

public extension Bundle {
    static var ui: Bundle {
        guard let bundleIdentifier = Bundle(for: UIBundleIdentifierClass.self)
            .infoDictionary?[kCFBundleIdentifierKey as String] as? String
        else { return Bundle.main }
        return Bundle(identifier: bundleIdentifier) ?? Bundle.main
    }
}
