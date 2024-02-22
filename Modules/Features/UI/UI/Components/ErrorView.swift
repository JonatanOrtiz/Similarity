//
//  ErrorView.swift
//  UI
//
//  Created by Jonatan Ortiz on 21/02/24.
//

import SwiftUI

public struct ErrorView: View {
    public typealias Action = () -> Void

    let image: AssetImage
    let title: String?
    let message: String?
    let primaryButton: ErrorViewButton?
    let secondaryButton: ErrorViewButton?

    public init(
        title: String?,
        message: String?,
        image: AssetImage = .brokenHeart,
        primaryButton: ErrorViewButton? = nil,
        secondaryButton: ErrorViewButton? = nil
    ) {
        self.image = image
        self.title = title
        self.message = message
        self.primaryButton = primaryButton
        self.secondaryButton = secondaryButton
    }

    public var body: some View {
        VStack(spacing: 15) {
            Spacer()
            Image.assetImage(image)
                .resizable()
                .scaledToFit()

            if let title, title.isNotEmpty {
                Text(title)
                    .titleBold()
            }

            if let message, message.isNotEmpty {
                Text(message)
                    .tertiaryTitle()
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.top, 20)
                    .padding(.horizontal, 25)
            }

            Spacer()

            if let primaryButton {
                FlatGlassButton(
                    text: primaryButton.title,
                    backgroundColor: .appBlue,
                    foregroundColor: .appWhite,
                    horizontalPadding: 15,
                    action: primaryButton.action
                )
            }

            if let secondaryButton {
                FlatGlassButton(
                    text: secondaryButton.title,
                    backgroundColor: .appPurple,
                    foregroundColor: .appWhite,
                    horizontalPadding: 15,
                    action: secondaryButton.action
                )
            }
            Spacer()
        }
        .backgroundImage()
    }
}

public struct ErrorViewButton {
    public typealias Action = () -> Void

    var title: String
    var action: Action

    public init(title: String, action: @escaping Action) {
        self.title = title
        self.action = action
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(
            title: "Profile Error",
            message: "Error trying to access profile data",
            primaryButton: .init(title: "Ok", action: {}),
            secondaryButton: .init(title: "Try Again", action: {})
        )
    }
}
