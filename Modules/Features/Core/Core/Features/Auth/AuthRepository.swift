//
//  AuthRepository.swift
//  Core
//
//  Created by Jonatan Ortiz on 31/08/23.
//

import Combine
import CoreInterface

public final class AuthRepository: Authenticating {
    @Published public var user: User?
    
    public static let shared: Authenticating = AuthRepository()
    
    private init() {
        self.user = FirebaseAuthService.currentUser()
    }
    
    public func signIn(email: String, password: String) -> AnyPublisher<User, Error> {
        FirebaseAuthService.signIn(email: email, password: password).eraseToAnyPublisher()
    }
    
    public func signInWithGoogle() -> AnyPublisher<User, Error> {
        GoogleAuthService.signIn().eraseToAnyPublisher()
    }

    public func signUpWithGoogle() -> AnyPublisher<User, Error> {
        GoogleAuthService.signIn().eraseToAnyPublisher()
    }
    
    public func signUp(email: String, password: String) -> AnyPublisher<User, Error> {
        FirebaseAuthService.signUp(email: email, password: password).eraseToAnyPublisher()
    }
    
    public func signOut() -> AnyPublisher<NoContent, Error> {
        FirebaseAuthService.signOut().eraseToAnyPublisher()
    }
}
