//
//  Image.swift
//  UI
//
//  Created by Jonatan Ortiz on 21/07/23.
//

import SwiftUI

// MARK: - AssetImage
public extension Image {
    static func asset(_ image: AssetImage) -> Self {
        return Image(image.rawValue, bundle: .ui)
    }

    static func asset(_ imageName: String) -> Self {
        return Image(imageName, bundle: .ui)
    }
}

// MARK: - AssetIcon
public extension Image {
    static func asset(_ image: AssetIcon) -> Self {
        return Image(image.rawValue, bundle: .ui)
    }
}
