//
//  FirebaseTracker.swift
//  Core
//
//  Created by Jonatan Ortiz on 16/10/23.
//

import CoreInterface
import FirebaseAnalytics

public typealias FirebaseContract = ThirdPartyTracker & ThirdPartyIdentifiable

public struct FirebaseTracker: FirebaseContract {
    public init() {}
    
    public func track(_ event: String, properties: [String: Any]) {
        FirebaseAnalytics.Analytics.logEvent(event, parameters: properties)
        print("Logged event: ", event)
        print("with properties: ", properties)
    }

    public func identify() {
        @Inject var auth: Authenticating
        
        guard let user = auth.user else { return }

        FirebaseAnalytics.Analytics.setUserProperty(String(user.uid), forName: "user_id")
        FirebaseAnalytics.Analytics.setUserProperty(user.email, forName: "user_email")
    }
}
