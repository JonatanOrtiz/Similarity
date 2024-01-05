//
//  HomeSampleApp.swift
//  HomeSample
//
//  Created by Jonatan Ortiz on 11/07/23.
//

import SwiftUI
import Home

@main
struct HomeSampleApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            NavigationHubView()
        }
    }
}
