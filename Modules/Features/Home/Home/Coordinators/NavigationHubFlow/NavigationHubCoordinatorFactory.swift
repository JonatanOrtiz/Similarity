//
//  NavigationHubCoordinatorFactory.swift
//  Home
//
//  Created by Jonatan Ortiz on 03/04/25.
//

import SwiftUI

public enum NavigationHubCoordinatorFactory {
    @MainActor
    public static func make() -> some View {
        let dependencies = DependencyContainer()
        let coordinator = NavigationHubCoordinator(dependencies: dependencies)
        return NavigationHubCoordinatorView(coordinator: coordinator)
    }
}

struct NavigationHubCoordinatorView: View {
    @StateObject var coordinator: NavigationHubCoordinator

    var body: some View {
        coordinator.makeContentView()
    }
}
