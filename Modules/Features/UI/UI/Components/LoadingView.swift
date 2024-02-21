//
//  LoadingView.swift
//  UI
//
//  Created by Jonatan Ortiz on 20/02/24.
//

import SwiftUI

public struct LoadingView: View {
    public var text: String?

    public init(text: String? = nil) {
        self.text = text
    }

    public var body: some View {
        VStack {
            Spacer()
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .primaryColor))
                .scaleEffect(2, anchor: .center)
            Text(text ?? Strings.Ui.loading)
                .headline()
                .padding(.top, 30)
            Spacer()
        }
        .backgroundImage()
    }
}
