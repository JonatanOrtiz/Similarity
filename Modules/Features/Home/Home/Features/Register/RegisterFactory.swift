//
//  RegisterFactory.swift
//  Home
//
//  Created by Jonatan Ortiz on 20/10/23.
//

import SwiftUI

enum RegisterFactory {
    @MainActor
    static func make(coordinator: AuthCoordinating) -> some View {
        let dependencyContainer = DependencyContainer()
        let viewModel = RegisterViewModel(dependencies: dependencyContainer)
        viewModel.coordinator = coordinator
        let contentView = RegisterView(viewModel: viewModel)
        return contentView
    }
}
