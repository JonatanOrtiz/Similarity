//
//  ProfileService.swift
//  Core
//
//  Created by Jonatan Ortiz on 08/02/24.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine
import CoreInterface

enum ProfileService {
    static func saveProfile(profile: AppProfile) -> AnyPublisher<Void, Error> {
        Deferred {
            Future { promise in
                do {
                    try Firestore.firestore().collection("profiles").document(profile.uid).setData(from: profile) { error in
                        if let error = error {
                            promise(.failure(error))
                        } else {
                            promise(.success(()))
                        }
                    }
                } catch let error as NSError {
                    promise(.failure(CustomError(
                        title: Strings.ProfileError.SaveProfile.title,
                        message: error.localizedDescription
                    )))
                } catch {
                    promise(.failure(CustomError(title: Strings.ProfileError.SaveProfile.title)))
                }
            }
        }
        .eraseToAnyPublisher()
    }

    static func fetchProfile(uid: String) -> AnyPublisher<AppProfile, Error> {
        Deferred {
            Future { promise in
                let docRef = Firestore.firestore().collection("profiles").document(uid)

                docRef.getDocument { document, error in
                    let result = Result {
                        try document.flatMap {
                            try $0.data(as: AppProfile.self)
                        }
                    }
                    switch result {
                        case .success(let profile):
                            if let profile = profile {
                                promise(.success(profile))
                            } else {
                                promise(.failure(CustomError(title: Strings.ProfileError.getProfile)))
                            }
                        case .failure(let error):
                            promise(.failure(error))
                    }
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
