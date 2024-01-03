//
//  SignInViewModel.swift
//  Home
//
//  Created by Jonatan Ortiz on 14/09/23.
//

import Combine
import CoreInterface

public protocol SignInViewModeling: ObservableObject {
    typealias Action = () -> Void

    var user: User? { get }
    var error: CustomError? { get set }
    var tryAgainAction: Action? { get set }

    func signIn(email: String, password: String)
    func signInWithGoogle()
}

final class SignInViewModel {
    typealias Dependencies = HasAuthentication & HasAnalytics

    @Published var user: User?
    @Published var error: CustomError?
    @Published var tryAgainAction: Action?

    private var cancellables = Set<AnyCancellable>()
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
}

extension SignInViewModel: SignInViewModeling {
    func signIn(email: String, password: String) {
        log(.buttonClicked(.signIn))
        dependencies.auth.signIn(email: email, password: password)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    if case let .failure(error) = completion {
                        self?.error = CustomError(title: Strings.Common.genericErrorTitle, message: error.localizedDescription, image: "error")
                        self?.tryAgainAction = { [weak self] in
                            _ = self?.signIn(email: email, password: password)
                        }
                    }
                },
                receiveValue: { [weak self] user in
                    self?.user = user
                }
            )
            .store(in: &cancellables)
    }
    
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
                            _ = self?.signInWithGoogle()
                        }
                    }
                },
                receiveValue: { [weak self] user in
                    self?.user = user
                }
            )
            .store(in: &cancellables)
    }
    
//    func signOut() {
//        dependencies.auth.signOut()
//            .receive(on: DispatchQueue.main)
//            .sink(
//                receiveCompletion: { [weak self] completion in
//                    switch completion {
//                    case .finished:
//                        break
//                    case let .failure(error):
//                        self?.errorMessage = error.localizedDescription
//                    }
//                },
//                receiveValue: { _ in }
//            )
//            .store(in: &cancellables)
//    }
}

extension SignInViewModel {
    func log(_ event: SignInAnalytics) {
        dependencies.analytics.log(event)
    }
}
