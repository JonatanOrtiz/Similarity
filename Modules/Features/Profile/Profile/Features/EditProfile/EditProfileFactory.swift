//
//  EditProfileFactory.swift
//  Profile
//
//  Created by Jonatan Ortiz on 27/02/24.
//

import SwiftUI

public enum EditProfileFactory {
    public static func make(profile: AppProfile) -> some View {
        let dependencyContainer = DependencyContainer()
        let viewModel = EditProfileViewModel(profile: profile, dependencies: dependencyContainer)
        let contentView = EditProfileView(viewModel: viewModel)

        return contentView
    }
}
