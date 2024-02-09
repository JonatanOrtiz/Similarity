//
//  ProfileFactory.swift
//  Profile
//
//  Created by Jonatan Ortiz on 08/02/24.
//

import SwiftUI

public enum ProfileFactory {
    public static func make() -> some View {
        let dependencyContainer = DependencyContainer()
        let viewModel = ProfileViewModel(dependencies: dependencyContainer)
        let contentView = ProfileView(viewModel: viewModel)

        return contentView
    }
}
