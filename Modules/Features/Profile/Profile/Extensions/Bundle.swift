//
//  Bundle.swift
//  Profile
//
//  Created by Jonatan Ortiz on 16/08/23.
//

class ProfileBundleIdentifierClass {}

public extension Bundle {
    static var profile: Bundle {
        guard let bundleIdentifier = Bundle(for: ProfileBundleIdentifierClass.self)
            .infoDictionary?[kCFBundleIdentifierKey as String] as? String
        else { return Bundle.main }
        return Bundle(identifier: bundleIdentifier) ?? Bundle.main
    }
}
