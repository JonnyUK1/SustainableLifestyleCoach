//
//  SustainableLifestyleCoachApp.swift
//  SustainableLifestyleCoach
//
//  Created by Jonny Walker on 16/01/2024.
//

import SwiftUI
import Firebase

@main
struct SustainableLifestyleCoachApp: App {
    @StateObject var viewModel = AuthViewModel()
    
    init () {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
