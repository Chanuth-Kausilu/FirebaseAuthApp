//
//  firebaseauthApp.swift
//  firebaseauth
//
//  Created by Chanuth Kausilu on 2026-01-05.
//

import SwiftUI
import Firebase

@main
struct firebaseauthApp: App {
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
