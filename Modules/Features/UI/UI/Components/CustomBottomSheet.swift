//
//  CustomBottomSheet.swift
//  UI
//
//  Created by Jonatan Ortiz on 01/04/24.
//

import SwiftUI

public struct CustomBottomSheet<Content>: View where Content: View {
    public typealias Action = () -> Void

    @State private var detentHeight: CGFloat = .zero

    let customView: Content
    let background: Color?
    let height: CGFloat?

    public init(customView: Content, background: Color?, height: CGFloat?) {
        self.customView = customView
        self.background = background
        self.height = height
    }

    public var body: some View {
        VStack {
            customView
        }
        .frame(height: height ?? detentHeight)
        .padding(.top, 30)
        .readHeight($detentHeight)
        .conditionalPresentationBackground(background)
        .presentationDragIndicator(.visible)
    }
}
