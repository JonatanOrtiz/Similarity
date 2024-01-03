//
//  AppDelegate.swift
//  HomeSample
//
//  Created by Jonatan Ortiz on 02/01/24.
//

import CoreInterface
import GoogleSignIn

// swiftlint:disable discouraged_optional_collection
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        DependencyOrchestrator.start()
        return true
    }

    @available(iOS 9.0, *)

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        GIDSignIn.sharedInstance.handle(url)
    }
}
// swiftlint:enable discouraged_optional_collection
