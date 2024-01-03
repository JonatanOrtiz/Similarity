//
//  AppDelegate.swift
//  Similarity
//
//  Created by Jonatan Ortiz on 16/10/23.
//

import CoreInterface
import GoogleSignIn

// swiftlint:disable discouraged_optional_collection
class AppDelegate: NSObject, UIApplicationDelegate {
    lazy var thirdParties = ThirdParties()
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        FirebaseConfigure.firebaseConfigure()
        DependencyOrchestrator.start()
        thirdParties.setup()
        return true
    }
    
    @available(iOS 9.0, *)
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        GIDSignIn.sharedInstance.handle(url)
    }
}
// swiftlint:enable discouraged_optional_collection
