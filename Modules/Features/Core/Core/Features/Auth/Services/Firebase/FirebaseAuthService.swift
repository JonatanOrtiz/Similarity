//
//  FirebaseAuthentication.swift
//  Core
//
//  Created by Jonatan Ortiz on 30/08/23.
//

import FirebaseAuth
import Combine
import CoreInterface

enum FirebaseAuthService {
    static func signIn(email: String, password: String) -> AnyPublisher<CoreInterface.User, Error> {
        Future { promise in
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let user = authResult?.user.toUser {
                    promise(.success(user))
                } else if let error = error {
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    static func signUp(email: String, password: String) -> AnyPublisher<CoreInterface.User, Error> {
        Future { promise in
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let user = authResult?.user.toUser {
                    promise(.success(user))
                } else if let error = error {
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    static func signOut() -> AnyPublisher<NoContent, Error> {
        return Future<NoContent, Error> { promise in
            do {
                try Auth.auth().signOut()
                promise(.success(NoContent()))
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
    
    static func currentUser() -> CoreInterface.User? {
        return Auth.auth().currentUser?.toUser
    }
}

extension FirebaseAuth.User {
    var toUser: CoreInterface.User {
        CoreInterface.User(uid: self.uid, email: self.email ?? String())
    }
}
