//
//  ThirdParties.swift
//  Similarity
//
//  Created by Jonatan Ortiz on 16/10/23.
//

import CoreInterface
import Core

struct ThirdParties {
    @Inject var analytics: AnalyticsProtocol
    
    func setup() {
        setupFirebase()
    }
    
    func setupFirebase() {
        analytics.register(tracker: FirebaseTracker(), for: .firebase)
    }
}
