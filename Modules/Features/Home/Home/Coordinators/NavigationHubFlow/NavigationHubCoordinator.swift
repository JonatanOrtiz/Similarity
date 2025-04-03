//
//  NavigationHubCoordinator.swift
//  Home
//
//  Created by Jonatan Ortiz on 03/04/25.
//

import SwiftUI
import Profile

protocol NavigationHubCoordinating: AnyObject {
    @MainActor func view(for tab: Tab) -> AnyView
}

final class NavigationHubCoordinator: ObservableObject {
    private let dependencies: HomeDependencies

    init(dependencies: HomeDependencies) {
        self.dependencies = dependencies
    }

    @MainActor
    @ViewBuilder
    func makeContentView() -> some View {
        NavigationHubFactory.make(coordinator: self)
    }

    // MARK: - Private Tab Views

    @MainActor private func makeConfigurationsView() -> some View {
        Text("Configurations View")
    }

    @MainActor private func makeLikesView() -> some View {
        Text("Likes View")
    }

    @MainActor private func makeProfilesListView() -> some View {
        Text("Profiles List View")
    }

    @MainActor private func makeMatchesView() -> some View {
        Text("Matches View")
    }

    @MainActor private func makeUserProfileView() -> some View {
        ProfileFactory.make()
    }
}

// MARK: - Tab Content Provider
extension NavigationHubCoordinator: NavigationHubCoordinating {
    @MainActor
    func view(for tab: Tab) -> AnyView {
        switch tab {
            case .configurations:
                return AnyView(makeConfigurationsView())
            case .likes:
                return AnyView(makeLikesView())
            case .profilesList:
                return AnyView(makeProfilesListView())
            case .matches:
                return AnyView(makeMatchesView())
            case .userProfile:
                return AnyView(makeUserProfileView())
        }
    }
}
