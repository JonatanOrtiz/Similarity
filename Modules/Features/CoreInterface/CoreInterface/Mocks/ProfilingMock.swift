//
//  ProfilingMock.swift
//  CoreInterface
//
//  Created by Jonatan Ortiz on 08/02/24.
//

import Combine

public enum ProfilingError: Error {
    case mockNotSetUp, unknown
}

public final class ProfilingMock: Profiling {
    public var fetchProfileResult: Result<AppProfile, Error>?
    public var saveProfileResult: Result<Void, Error>?

    public init() {}

    public private(set) var fetchProfileInvocations: [String] = []
    public func fetchProfile(uid: String) -> AnyPublisher<AppProfile, Error> {
        fetchProfileInvocations.append(uid)
        return executeFetchProfile()
    }

    public private(set) var saveProfileInvocations: [AppProfile] = []
    public func saveProfile(profile: AppProfile) -> AnyPublisher<Void, Error> {
        saveProfileInvocations.append(profile)
        return executeSaveProfile()
    }

    private func executeFetchProfile() -> AnyPublisher<AppProfile, Error> {
        guard let result = fetchProfileResult else {
            return Fail(error: ProfilingError.mockNotSetUp).eraseToAnyPublisher()
        }
        return result.publisher.eraseToAnyPublisher()
    }

    private func executeSaveProfile() -> AnyPublisher<Void, Error> {
        guard let result = saveProfileResult else {
            return Fail(error: ProfilingError.mockNotSetUp).eraseToAnyPublisher()
        }
        return result.publisher.eraseToAnyPublisher()
    }
}
