//
//  UserSession.swift
//  CoreInterface
//
//  Created by Jonatan Ortiz on 08/02/24.
//

public class UserSession: ObservableObject {
    @Published public var user: AppUser

    public init(user: AppUser) {
        self.user = user
    }
}
