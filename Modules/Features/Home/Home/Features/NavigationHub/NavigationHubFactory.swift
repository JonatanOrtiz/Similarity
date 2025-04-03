//
//  NavigationHubFactory.swift
//  Home
//
//  Created by Jonatan Ortiz on 02/04/25.
//

import SwiftUI

enum NavigationHubFactory {
    @MainActor
    static func make(coordinator: NavigationHubCoordinating) -> some View {
        let viewModel = NavigationHubViewModel()
        viewModel.coordinator = coordinator
        let contentView = NavigationHubView(viewModel: viewModel)
        return contentView
    }
}
