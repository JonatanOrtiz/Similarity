//
//  SimilarityApp.swift
//  Similarity
//
//  Created by Jonatan Ortiz on 03/07/23.
//

import SwiftUI
import Home
import CoreInterface

@main
struct SimilarityApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            AppEntryPoint()
        }
    }
}

struct AppEntryPoint: View {
    @Inject var auth: Authenticating
    
    var body: some View {
        if auth.user != nil {
            NavigationHubContentView()
        } else {
            SignInFactory.make()
        }
    }
}
