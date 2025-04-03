import SwiftUI

public protocol AuthCoordinating: AnyObject {
    @MainActor func showRegister()
    @MainActor func showSignIn()
    func didFinishAuth()
}

public final class AuthCoordinator: ObservableObject {
    public enum Route: Hashable {
        case register
    }
    
    @Published var navigationPath = NavigationPath()
    private let dependencies: HomeDependencies
    
    init(dependencies: HomeDependencies) {
        self.dependencies = dependencies
    }
    
    @MainActor
    @ViewBuilder
    public func makeContentView() -> some View {
        NavigationStack(path: Binding(
            get: { self.navigationPath },
            set: { self.navigationPath = $0 }
        )) {
            makeSignInView()
                .navigationDestination(for: Route.self) { route in
                    switch route {
                        case .register:
                            self.makeRegisterView()
                    }
                }
        }
    }
    
    @MainActor
    private func makeSignInView() -> some View {
        SignInFactory.make(coordinator: self)
    }
    
    @MainActor
    private func makeRegisterView() -> some View {
        RegisterFactory.make(coordinator: self)
    }
}

extension AuthCoordinator: AuthCoordinating {
    @MainActor
    public func showRegister() {
        navigationPath.append(Route.register)
    }
    
    @MainActor
    public func showSignIn() {
        if !navigationPath.isEmpty {
            navigationPath.removeLast()
        }
    }
    
    public func didFinishAuth() {
        print("Authentication Finished!")
    }
}
