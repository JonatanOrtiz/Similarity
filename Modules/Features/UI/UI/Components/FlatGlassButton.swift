//
//  Button.swift
//  UI
//
//  Created by Jonatan Ortiz on 04/10/23.
//

import SwiftUI

public struct FlatGlassButton: View {
    public typealias Action = () -> Void
    
    let text: String
    let backgroundColor: Color
    let foregroundColor: Color?
    let horizontalPadding: CGFloat?
    let action: Action
    
    public init(
        text: String,
        backgroundColor: Color,
        foregroundColor: Color? = nil,
        horizontalPadding: CGFloat? = nil,
        action: @escaping Action
    ) {
        self.text = text
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.horizontalPadding = horizontalPadding
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            Text(text).bodyBold(foregroundColor)
        }
        .frame(height: 45)
        .frame(maxWidth: .infinity)
        .background(backgroundColor)
        .flatGlassCard()
        .padding(.horizontal, horizontalPadding ?? 10)
    }
}
