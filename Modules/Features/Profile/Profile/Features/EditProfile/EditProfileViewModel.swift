//
//  EditProfileViewModel.swift
//  Profile
//
//  Created by Jonatan Ortiz on 27/02/24.
//

import Combine
import CoreInterface

public protocol EditProfileViewModeling: ObservableObject {
    var profile: AppProfile { get set }
}

final class EditProfileViewModel: EditProfileViewModeling {
    typealias Dependencies = HasAnalytics

    private let dependencies: Dependencies
    
    @Published var profile: AppProfile

    init(profile: AppProfile, dependencies: Dependencies) {
        self.profile = profile
        self.dependencies = dependencies
    }
}
