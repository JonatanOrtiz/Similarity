//
//  FirebaseConfiguring.swift
//  CoreInterface
//
//  Created by Jonatan Ortiz on 02/10/23.
//

import Firebase

public enum FirebaseConfigure {
    public static func firebaseConfigure() {
        let googleServicePlist: String
        #if DEVELOPMENT || DEBUG
        googleServicePlist = "GoogleService-Info-Dev"
        #else
        googleServicePlist = "GoogleService-Info"
        #endif

        print(Bundle.main)
        let filePath = Bundle.main.path(forResource: googleServicePlist, ofType: "plist")
        if let path = filePath, let opts = FirebaseOptions(contentsOfFile: path) {
            FirebaseApp.configure(options: opts)
        } else {
            print("Error on googleServicePlist path")
        }
    }
}
