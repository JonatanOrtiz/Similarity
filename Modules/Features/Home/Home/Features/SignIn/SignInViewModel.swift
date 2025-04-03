//
//  SignInViewModel.swift
//  Home
//
//  Created by Jonatan Ortiz on 14/09/23.
//

import Combine
import CoreInterface
import SwiftUI

protocol SignInViewModeling: ObservableObject {
    typealias Action = () -> Void

    var user: AppUser? { get }
    var error: CustomError? { get set }
    var tryAgainAction: Action? { get set }

    @MainActor func signIn(email: String, password: String)
    @MainActor func signInWithGoogle()
    @MainActor func navigateToRegister()
}

final class SignInViewModel {
    typealias Dependencies = HasAuthentication & HasAnalytics

    @Published var user: AppUser?
    @Published var error: CustomError?
    @Published var tryAgainAction: Action?

    private var cancellables = Set<AnyCancellable>()
    private let dependencies: Dependencies
    weak var coordinator: AuthCoordinating?
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
}

extension SignInViewModel: SignInViewModeling {
    @MainActor
    func signIn(email: String, password: String) {
        log(.buttonClicked(.signIn))
        dependencies.auth.signIn(email: email, password: password)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    if case let .failure(error) = completion {
                        self?.error = CustomError(title: Strings.Common.genericErrorTitle, message: error.localizedDescription, image: "error")
                        self?.tryAgainAction = { [weak self] in
                            self?.signIn(email: email, password: password)
                        }
                    }
                },
                receiveValue: { [weak self] user in
                    self?.user = user
                    self?.coordinator?.didFinishAuth()
                }
            )
            .store(in: &cancellables)
    }
    
    @MainActor
    func signInWithGoogle() {
        log(.buttonClicked(.signInWithGoogle))
        dependencies.auth.signInWithGoogle()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    if case let .failure(error) = completion {
                        if let customError = error as? CustomError {
                            self?.error = customError
                        }
                        self?.tryAgainAction = { [weak self] in
                            self?.signInWithGoogle()
                        }
                    }
                },
                receiveValue: { [weak self] user in
                    self?.user = user
                    self?.coordinator?.didFinishAuth()
                }
            )
            .store(in: &cancellables)
    }
    
    @MainActor
    func navigateToRegister() {
        log(.buttonClicked(.register))
        coordinator?.showRegister()
    }
}

extension SignInViewModel {
    func log(_ event: SignInAnalytics) {
        dependencies.analytics.log(event)
    }
}
