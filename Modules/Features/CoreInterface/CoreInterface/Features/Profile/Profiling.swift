//
//  Profiling.swift
//  CoreInterface
//
//  Created by Jonatan Ortiz on 08/02/24.
//

import Combine

public protocol HasProfile {
    var profiling: Profiling { get }
}

public protocol Profiling {
    func fetchProfile(uid: String) -> AnyPublisher<AppProfile, Error>
    func saveProfile(profile: AppProfile) -> AnyPublisher<Void, Error>
}
