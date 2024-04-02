//
//  FeedBackBottomSheet.swift
//  UI
//
//  Created by Jonatan Ortiz on 04/10/23.
//

import SwiftUI

public struct FeedBackBottomSheet: View {
    public typealias Action = () -> Void
    
    @State private var detentHeight: CGFloat = .zero
    
    let image: AssetImage?
    let title: String?
    let message: String?
    let primaryButton: FeedBackBottomSheetButton?
    let secondaryButton: FeedBackBottomSheetButton?
    
    public init(
        image: AssetImage?,
        title: String?,
        message: String?,
        primaryButton: FeedBackBottomSheetButton? = nil,
        secondaryButton: FeedBackBottomSheetButton? = nil
    ) {
        self.image = image
        self.title = title
        self.message = message
        self.primaryButton = primaryButton
        self.secondaryButton = secondaryButton
    }
    
    public var body: some View {
        VStack(spacing: 15) {
            if let image {
                Image.assetImage(image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight / 7)
            }

            if let title, title.isNotEmpty {
                Text(title)
                    .secondaryTitleBold()
            }

            if let message, message.isNotEmpty {
                Text(message)
                    .calloutBold()
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.bottom, 5)
                    .padding(.horizontal, 25)
            }

            if let primaryButton {
                FlatGlassButton(
                    text: primaryButton.title,
                    backgroundColor: .appBlue.opacity(0.2),
                    foregroundColor: .white.opacity(0.75),
                    horizontalPadding: 15,
                    action: primaryButton.action
                )
            }
            
            if let secondaryButton {
                FlatGlassButton(
                    text: secondaryButton.title,
                    backgroundColor: .appPurple.opacity(0.2),
                    foregroundColor: .white.opacity(0.75),
                    horizontalPadding: 15,
                    action: secondaryButton.action
                )
            }
        }
        .padding(.top, 30)
        .readHeight($detentHeight)
        .presentationBackground(Color.primaryReverse)
        .presentationDragIndicator(.visible)
    }
}

public struct FeedBackBottomSheetButton {
    public typealias Action = () -> Void

    var title: String
    var action: Action

    public init(title: String, action: @escaping Action) {
        self.title = title
        self.action = action
    }
}
