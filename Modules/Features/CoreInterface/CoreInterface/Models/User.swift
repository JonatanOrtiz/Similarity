//
//  User.swift
//  CoreInterface
//
//  Created by Jonatan Ortiz on 29/09/23.
//

public struct User: Decodable {
    public let uid: String
    public let email: String
    
    public init(uid: String, email: String) {
        self.uid = uid
        self.email = email
    }
}
