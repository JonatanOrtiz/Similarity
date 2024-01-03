//
//  ReadHeightModifier.swift
//  UI
//
//  Created by Jonatan Ortiz on 04/10/23.
//

import SwiftUI

struct ReadHeightModifier: ViewModifier {
    private var sizeView: some View {
        GeometryReader { geometry in
            Color.clear.preference(key: HeightPreferenceKey.self, value: geometry.size.height)
        }
    }

    func body(content: Content) -> some View {
        content.background(sizeView)
    }
}
