//
//  Authenticating.swift
//  CoreInterface
//
//  Created by Jonatan Ortiz on 29/09/23.
//

import Combine

public protocol HasAuthentication {
    var auth: Authenticating { get }
}

public protocol Authenticating {
    func signIn(email: String, password: String) -> AnyPublisher<User, Error>
    func signInWithGoogle() -> AnyPublisher<User, Error>
    func signUpWithGoogle() -> AnyPublisher<User, Error>
    func signUp(email: String, password: String) -> AnyPublisher<User, Error>
    func signOut() -> AnyPublisher<NoContent, Error>
    var user: User? { get }
}
