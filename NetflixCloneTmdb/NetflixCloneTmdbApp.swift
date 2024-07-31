//
//  NetflixCloneTmdbApp.swift
//  NetflixCloneTmdb
//
//  Created by Kerem on 3.07.2024.
//

import SwiftUI

@main
struct NetflixCloneTmdbApp: App {
    
    @AppStorage("hasSeenOnboarding") var hasSeenOnboarding: Bool = false
    
    var body: some Scene {
        WindowGroup {
            if hasSeenOnboarding {
                HomeView()
            }else {
                StartView()
            }
            
        }
    }
}
