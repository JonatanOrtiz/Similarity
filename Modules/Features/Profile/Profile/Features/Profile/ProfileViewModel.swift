//
//  ProfileViewModel.swift
//  Profile
//
//  Created by Jonatan Ortiz on 08/02/24.
//

import Combine
import CoreInterface

public protocol ProfileViewModeling: ObservableObject {
    typealias Action = () -> Void

    var profile: AppProfile? { get set }
    var error: CustomError? { get set }
    var tryAgainAction: Action? { get set }

    func fetchProfile()
    func saveProfile(profile: AppProfile)
}

final class ProfileViewModel: ProfileViewModeling {
    typealias Dependencies = HasAuthentication & HasProfile & HasAnalytics

    @Published var profile: AppProfile?
    @Published var error: CustomError?
    @Published var tryAgainAction: Action?

    private var cancellables = Set<AnyCancellable>()
    private let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
}

extension ProfileViewModel {
    func fetchProfile() {
        guard let userId = dependencies.auth.user?.uid else {
            return handleError(CustomError(
                title: Strings.Common.genericErrorTitle,
                message: Strings.ProfileError.getUserId
            )) { [weak self] in
                self?.fetchProfile()
            }
        }

        dependencies.profiling.fetchProfile(uid: userId)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    switch completion {
                        case .failure(let error):
                            self?.handleError(error) {
                                self?.fetchProfile()
                            }
                        case .finished: 
                            break
                    }
                },
                receiveValue: { [weak self] profile in
                    self?.profile = profile
                }
            )
            .store(in: &cancellables)
    }

    func saveProfile(profile: AppProfile) {
        dependencies.profiling.saveProfile(profile: profile)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    switch completion {
                        case .failure(let error):
                            self?.handleError(error) {
                                self?.saveProfile(profile: profile)
                            }
                        case .finished: 
                            break
                    }
                },
                receiveValue: { _ in
                    // Profile saved successfully
                }
            )
            .store(in: &cancellables)
    }

    private func handleError(_ error: Error, retryAction: @escaping Action) {
        if let customError = error as? CustomError {
            self.error = customError
        } else {
            self.error = CustomError(
                title: Strings.Common.genericErrorTitle,
                message: error.localizedDescription
            )
        }
        self.tryAgainAction = retryAction
    }
}
