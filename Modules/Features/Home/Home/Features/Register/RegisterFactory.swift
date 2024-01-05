//
//  RegisterFactory.swift
//  Home
//
//  Created by Jonatan Ortiz on 20/10/23.
//

import SwiftUI

public enum RegisterFactory {
    public static func make() -> some View {
        let dependencyContainer = DependencyContainer()
        let viewModel = RegisterViewModel(dependencies: dependencyContainer)
        let contentView = RegisterView(viewModel: viewModel)

        return contentView
    }
}
