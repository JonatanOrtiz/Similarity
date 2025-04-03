//
//  RegisterViewModel.swift
//  Home
//
//  Created by Jonatan Ortiz on 20/10/23.
//

import Combine
import CoreInterface
import SwiftUI

public protocol RegisterViewModeling: ObservableObject {
    typealias Action = () -> Void

    var user: AppUser? { get }
    var error: CustomError? { get set }
    var tryAgainAction: Action? { get set }

    @MainActor func signUp(email: String, password: String)
    @MainActor func signUpWithGoogle()
    @MainActor func navigateBack()
}

final class RegisterViewModel {
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

extension RegisterViewModel: RegisterViewModeling {
    @MainActor
    func signUp(email: String, password: String) {
        log(.buttonClicked(.signUp))
        dependencies.auth.signUp(email: email, password: password)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    if case let .failure(error) = completion {
                        self?.error = CustomError(title: Strings.Common.genericErrorTitle, message: error.localizedDescription, image: "error")
                        self?.tryAgainAction = { [weak self] in
                            self?.signUp(email: email, password: password)
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
    func signUpWithGoogle() {
        log(.buttonClicked(.signUpWithGoogle))
        dependencies.auth.signInWithGoogle()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    if case let .failure(error) = completion {
                        self?.error = CustomError(title: Strings.Common.genericErrorTitle, message: error.localizedDescription)
                        self?.tryAgainAction = { [weak self] in
                            self?.signUpWithGoogle()
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
    func navigateBack() {
        log(.buttonClicked(.back))
        coordinator?.showSignIn()
    }
}

extension RegisterViewModel {
    func log(_ event: RegisterAnalytics) {
        dependencies.analytics.log(event)
    }
}
