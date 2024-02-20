//
//  DocumentDatabaseConfiguration.swift
//  CoreInterface
//
//  Created by Jonatan Ortiz on 19/02/24.
//

public struct DocumentDatabaseConfiguration: DataServiceConfiguration {
    public var collectionPath: DataBaseCollections
    public var documentId: String?
    public var data: Encodable?
    public var fieldsToUpdate: [String: Any]?

    public init(
        collectionPath: DataBaseCollections,
        documentId: String? = nil,
        data: Encodable? = nil,
        fieldsToUpdate: [ String: Any ]? = nil
    ) {
        self.collectionPath = collectionPath
        self.documentId = documentId
        self.data = data
        self.fieldsToUpdate = fieldsToUpdate
    }
}
