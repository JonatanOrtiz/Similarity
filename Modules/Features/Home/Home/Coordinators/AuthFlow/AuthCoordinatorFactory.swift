import SwiftUI

public enum AuthCoordinatorFactory {
    @MainActor
    public static func make() -> some View {
        let dependencyContainer = DependencyContainer()
        let coordinator = AuthCoordinator(dependencies: dependencyContainer)
        return AuthCoordinatorView(coordinator: coordinator)
    }
}

struct AuthCoordinatorView: View {
    @StateObject var coordinator: AuthCoordinator

    var body: some View {
        coordinator.makeContentView()
    }
}
