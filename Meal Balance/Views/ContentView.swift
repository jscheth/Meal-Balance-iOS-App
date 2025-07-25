//
//  ContentView.swift
//  Meal Balance
//
//  Created by Jonathan Cheth on 7/1/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var authController = AuthenticationController()
    @StateObject private var profileController = ProfileController()
    @StateObject private var onboardingViewModel = OnboardingViewModel()

    var body: some View {
        Group {
            // If there is no active user session, show the sign-in screen.
            if authController.userSession == nil {
                SignInView()
            } else {
                // If a user is logged in, show the main HomeView.
                HomeView()
                    .onAppear {
                        // When the HomeView appears, fetch the user's profile from Firestore.
                        if let userId = authController.userSession?.uid {
                            Task {
                                await profileController.fetchUserProfile(userId: userId)
                            }
                        }
                    }
            }
        }
        // Provide all the controllers to the entire view hierarchy.
        .environmentObject(authController)
        .environmentObject(profileController)
        .environmentObject(onboardingViewModel)
    }
}

#Preview {
    ContentView()
        .environmentObject(OnboardingViewModel())
}
