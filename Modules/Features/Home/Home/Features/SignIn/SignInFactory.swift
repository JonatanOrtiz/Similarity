//
//  SignInFactory.swift
//  Home
//
//  Created by Jonatan Ortiz on 20/09/23.
//

import SwiftUI

public enum SignInFactory {
    @MainActor
    public static func make(coordinator: AuthCoordinating) -> some View {
        let dependencyContainer = DependencyContainer()
        let viewModel = SignInViewModel(dependencies: dependencyContainer)
        viewModel.coordinator = coordinator
        let contentView = SignInView(viewModel: viewModel)
        return contentView
    }
}
