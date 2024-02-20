//
//  FirestoreDataService.swift
//  Core
//
//  Created by Jonatan Ortiz on 19/02/24.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine
import CoreInterface

enum FirestoreDataService {
    static func execute<T: Codable>(
        operation: DataServiceOperation,
        configuration: DocumentDatabaseConfiguration
    ) -> AnyPublisher<T, Error> {
        switch operation {
            case .fetch:
                return fetch(configuration: configuration)
            case .save:
                return save(configuration: configuration)
            case .update:
                return update(configuration: configuration)
            case .delete:
                return delete(configuration: configuration)
        }
    }

    private static func fetch<T: Codable>(
        configuration: DocumentDatabaseConfiguration
    ) -> AnyPublisher<T, Error> {
        Deferred {
            Future { promise in
                guard let documentId = configuration.documentId else {
                    promise(.failure(CustomError(title: Strings.FirestoreDataError.requiredDocumentID)))
                    return
                }
                let docRef = Firestore.firestore().collection(configuration.collectionPath.rawValue).document(documentId)
                docRef.getDocument { document, error in
                    guard let document = document, document.exists, error == nil else {
                        promise(.failure(error ?? CustomError(title: Strings.FirestoreDataError.documentNotFound)))
                        return
                    }
                    do {
                        let documentData = try document.data(as: T.self)
                        promise(.success(documentData))
                    } catch {
                        promise(.failure(error))
                    }
                }
            }
        }.eraseToAnyPublisher()
    }

    private static func save<T: Codable>(
        configuration: DocumentDatabaseConfiguration
    ) -> AnyPublisher<T, Error> {
        Deferred {
            Future { promise in
                guard let data = configuration.data else {
                    promise(.failure(CustomError(title: Strings.FirestoreDataError.requiredData)))
                    return
                }
                let documentId = configuration.documentId ?? Firestore.firestore().collection(configuration.collectionPath.rawValue).document().documentID
                let docRef = Firestore.firestore().collection(configuration.collectionPath.rawValue).document(documentId)
                do {
                    try docRef.setData(from: data) { error in
                        if let error = error {
                            promise(.failure(error))
                        } else {
                            guard let data = data as? T else {
                                promise(.failure(CustomError(title: Strings.FirestoreDataError.castingGenericT(T.self))))
                                return
                            }
                            promise(.success(data))
                        }
                    }
                } catch {
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }

    private static func update<T: Codable>(
        configuration: DocumentDatabaseConfiguration
    ) -> AnyPublisher<T, Error> {
        Deferred {
            Future { promise in
                guard let documentId = configuration.documentId, let fieldsToUpdate = configuration.fieldsToUpdate else {
                    promise(.failure(CustomError(title: Strings.FirestoreDataError.requiredDocumentIDAndFields)))
                    return
                }
                let docRef = Firestore.firestore().collection(configuration.collectionPath.rawValue).document(documentId)
                docRef.updateData(fieldsToUpdate) { error in
                    if let error = error {
                        promise(.failure(error))
                    } else {
                        docRef.getDocument { document, error in
                            guard let document = document, document.exists, error == nil else {
                                promise(.failure(error ?? CustomError(title: Strings.FirestoreDataError.documentNotFoundUpdate)))
                                return
                            }
                            do {
                                let updatedDocument = try document.data(as: T.self)
                                promise(.success(updatedDocument))
                            } catch {
                                promise(.failure(error))
                            }
                        }
                    }
                }
            }
        }.eraseToAnyPublisher()
    }

    private static func delete<T: Codable>(
        configuration: DocumentDatabaseConfiguration
    ) -> AnyPublisher<T, Error> {
        Deferred {
            Future { promise in
                guard let documentId = configuration.documentId else {
                    promise(.failure(CustomError(title: Strings.FirestoreDataError.requiredDocumentIDForDelete)))
                    return
                }
                Firestore.firestore().collection(configuration.collectionPath.rawValue).document(documentId).delete { error in
                    if let error = error {
                        promise(.failure(error))
                    } else {
                        if T.self == NoContent.self, let noContent = NoContent() as? T {
                            promise(.success(noContent))
                        } else {
                            promise(.failure(CustomError(title: Strings.FirestoreDataError.deleteDoesNotReturnData)))
                        }
                    }
                }
            }
        }.eraseToAnyPublisher()
    }
}
