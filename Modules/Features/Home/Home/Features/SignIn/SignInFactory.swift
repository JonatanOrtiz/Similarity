//
//  SignInFactory.swift
//  Home
//
//  Created by Jonatan Ortiz on 20/09/23.
//

import SwiftUI

public enum SignInFactory {
    public static func make() -> some View {
        let dependencyContainer = DependencyContainer()
        let viewModel = SignInViewModel(dependencies: dependencyContainer)
        let contentView = SignInView(viewModel: viewModel)
        
        return contentView
    }
}
