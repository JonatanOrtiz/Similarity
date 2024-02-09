//
//  ProfileRepository.swift
//  Core
//
//  Created by Jonatan Ortiz on 08/02/24.
//

import Combine
import CoreInterface

public final class ProfileRepository: Profiling {
    public static let shared = ProfileRepository()

    private init() {}

    public func fetchProfile(uid: String) -> AnyPublisher<AppProfile, Error> {
        ProfileService.fetchProfile(uid: uid).eraseToAnyPublisher()
    }

    public func saveProfile(profile: AppProfile) -> AnyPublisher<Void, Error> {
        ProfileService.saveProfile(profile: profile).eraseToAnyPublisher()
    }
}
