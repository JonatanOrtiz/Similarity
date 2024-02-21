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

    var profile: AppProfile? { get }
    var error: CustomError? { get }
    var tryAgainAction: Action? { get set }
    var isLoading: Bool { get }

    func fetchProfile()
}

final class ProfileViewModel: ProfileViewModeling {
    typealias Dependencies = HasAuthentication & HasDataManagement & HasAnalytics

    @Published var profile: AppProfile?
    @Published var error: CustomError?
    @Published var tryAgainAction: Action?
    @Published var isLoading = true {
        didSet {
            print(oldValue)
        }
    }

    private var cancellables = Set<AnyCancellable>()
    private let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
}

extension ProfileViewModel {
    func fetchProfile() {
        isLoading = true
        error = nil

        guard let userId = dependencies.auth.user?.uid else {
            handleError(CustomError(
                title: Strings.Common.genericErrorTitle,
                message: Strings.ProfileError.getUserId
            )) { [weak self] in
                self?.fetchProfile()
            }
            isLoading = false
            return
        }

        let databaseConfiguration = DocumentDatabaseConfiguration(
            collectionPath: .profiles,
            documentId: userId,
            data: nil,
            fieldsToUpdate: nil
        )

        dependencies.dataManagement.execute(operation: .fetch, configuration: databaseConfiguration)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    self?.isLoading = false
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
