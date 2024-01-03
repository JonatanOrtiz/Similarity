//
//  AuthenticationMock.swift
//  CoreInterface
//
//  Created by Jonatan Ortiz on 16/10/23.
//

import Combine

public enum AuthenticationError: Error {
    case mockNotSetUp, unknown
}

public enum AuthenticationAction: String {
    case signIn, signUp, signInWithGoogle, signUpWithGoogle, signOut
}

public final class AuthenticationMock<T>: Authenticating {
    public var user: User?
    public var expectedResult: Result<T, Error>?
    
    public init() {}
    
    public private(set) var signInInvocations: [(email: String, password: String)] = []
    public func signIn(email: String, password: String) -> AnyPublisher<User, Error> {
        signInInvocations.append((email: email, password: password))
        return executeRequest(for: .signIn)
    }
    
    public private(set) var signUpInvocations: [(email: String, password: String)] = []
    public func signUp(email: String, password: String) -> AnyPublisher<User, Error> {
        signUpInvocations.append((email: email, password: password))
        return executeRequest(for: .signUp)
    }
    
    public private(set) var signInWithGoogleCount = 0
    public func signInWithGoogle() -> AnyPublisher<User, Error> {
        signInWithGoogleCount += 1
        return executeRequest(for: .signInWithGoogle)
    }
    
    public private(set) var signUpWithGoogleCount = 0
    public func signUpWithGoogle() -> AnyPublisher<User, Error> {
        signUpWithGoogleCount += 1
        return executeRequest(for: .signUpWithGoogle)
    }
    
    public private(set) var signOutCount = 0
    public func signOut() -> AnyPublisher<NoContent, Error> {
        signOutCount += 1
        return executeRequest(for: .signOut)
    }
    
    private func executeRequest<T>(for action: AuthenticationAction) -> AnyPublisher<T, Error> where T: Decodable {
        guard let result = expectedResult as? Result<T, Error> else {
            return Fail(error: AuthenticationError.mockNotSetUp).eraseToAnyPublisher()
        }
        return result.publisher.eraseToAnyPublisher()
    }
}
