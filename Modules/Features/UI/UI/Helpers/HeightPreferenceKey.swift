//
//  HeightPreferenceKey.swift
//  UI
//
//  Created by Jonatan Ortiz on 04/10/23.
//
import SwiftUI

struct HeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat?

    static func reduce(value: inout CGFloat?, nextValue: () -> CGFloat?) {
        guard let nextValue = nextValue() else { return }
        value = nextValue
    }
}
