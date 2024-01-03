//
//  Image.swift
//  UI
//
//  Created by Jonatan Ortiz on 21/07/23.
//

import SwiftUI

public extension Image {
    static func asset(_ image: AssetImage) -> Self {
        return Image(image.rawValue, bundle: .ui)
    }

    static func asset(_ imageName: String) -> Self {
        return Image(imageName, bundle: .ui)
    }
}
