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
    func signIn(email: String, password: String) -> AnyPublisher<AppUser, Error>
    func signInWithGoogle() -> AnyPublisher<AppUser, Error>
    func signUpWithGoogle() -> AnyPublisher<AppUser, Error>
    func signUp(email: String, password: String) -> AnyPublisher<AppUser, Error>
    func signOut() -> AnyPublisher<NoContent, Error>
    var user: AppUser? { get }
}
