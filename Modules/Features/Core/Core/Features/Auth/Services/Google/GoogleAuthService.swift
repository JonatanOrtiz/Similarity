//
//  GoogleAuthService.swift
//  Core
//
//  Created by Jonatan Ortiz on 30/09/23.
//

import Combine
import CoreInterface
import FirebaseCore
import GoogleSignIn
import FirebaseAuth

enum GoogleAuthService {
    static func signIn() -> AnyPublisher<AppUser, Error> {
        Future { promise in
            guard let clientID = FirebaseApp.app()?.options.clientID else {
                promise(.failure(CustomError(title: Strings.GenericError.title, message: Strings.GoogleSignInError.clientID)))
                return
            }
            
            let config = GIDConfiguration(clientID: clientID)
            GIDSignIn.sharedInstance.configuration = config
            
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let window = windowScene.windows.first,
                  let presentingViewController = window.rootViewController
            else {
                promise(.failure(CustomError(title: Strings.GenericError.title, message: Strings.GoogleSignInError.presentingViewController)))
                return
            }
            
            GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { user, error in
                if let error = error {
                    promise(.failure(CustomError(title: Strings.GenericError.title, message: error.localizedDescription)))
                    return
                }
                
                guard let user = user?.user, let idToken = user.idToken else {
                    promise(.failure(CustomError(title: Strings.GenericError.title, message: Strings.GoogleSignInError.token)))
                    return
                }
                
                let accessToken = user.accessToken
                let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken: accessToken.tokenString)
                
                Auth.auth().signIn(with: credential) { response, error in
                    if let error = error {
                        promise(.failure(CustomError(title: Strings.GenericError.title, message: error.localizedDescription)))
                    }
                    
                    guard let user = response?.user.toUser else {
                        promise(.failure(CustomError(title: Strings.GenericError.title, message: Strings.GoogleSignInError.createUser)))
                        return
                    }
                    
                    promise(.success(user))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
