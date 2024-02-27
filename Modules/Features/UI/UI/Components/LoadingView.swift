//
//  LoadingView.swift
//  UI
//
//  Created by Jonatan Ortiz on 21/02/24.
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
            Spinner()
            if let text {
                Text(text)
                    .headline()
                    .padding(.top, 30)
            }
            Spacer()
        }
        .backgroundImage()
    }
}

#Preview {
    LoadingView()
}
