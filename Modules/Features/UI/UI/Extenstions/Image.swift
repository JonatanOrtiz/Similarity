//
//  Image.swift
//  UI
//
//  Created by Jonatan Ortiz on 21/07/23.
//

import SwiftUI

// MARK: - AssetImage
public extension Image {
    static func assetImage(_ image: AssetImage) -> Self {
        Image(image.rawValue, bundle: .ui)
    }
}

// MARK: - AssetIcon
public extension Image {
    static func assetIcon(_ image: AssetIcon) -> Self {
        Image(image.rawValue, bundle: .ui)
    }
}

// MARK: - String Asset
public extension Image {
    static func asset(_ imageName: String) -> Self {
        Image(imageName, bundle: .ui)
    }
}

// MARK: - SFSymbol
public extension Image {
    static func assetSFSymbol(_ image: SFSymbol, color: Color? = nil) -> some View {
        Image(systemName: image.rawValue)
            .renderingMode(.template)
            .foregroundColor(.appWhite)
            .font(.system(size: 12))
    }
}
