//
//  CongratulationsView.swift
//  Meal Balance
//
//  Created by Jonathan Cheth on 7/8/25.
//

import SwiftUI

struct CongratulationsView: View {
    @EnvironmentObject var auth: AuthenticationController
    @EnvironmentObject var profile: ProfileController
    @EnvironmentObject var onboardingViewModel: OnboardingViewModel
    
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage: String?

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Create Your Account").font(.largeTitle).fontWeight(.bold)
                Text("Just one last step to save your personalized plan.").foregroundColor(.secondary)
                TextField("Email", text: $email).textFieldStyle(RoundedBorderTextFieldStyle()).autocapitalization(.none).keyboardType(.emailAddress)
                SecureField("Password", text: $password).textFieldStyle(RoundedBorderTextFieldStyle())
                if let errorMessage = errorMessage { Text(errorMessage).foregroundColor(.red).font(.caption) }
                Button(action: handleCreateAccount) {
                    Text("Create Account & Finish").font(.headline).foregroundColor(.white).frame(maxWidth: .infinity).padding().background(Color.blue).cornerRadius(12)
                }
            }.padding()
        }
        .background(Color.black.ignoresSafeArea())
        .navigationBarTitle("Final Step", displayMode: .inline)
    }
    
    private func handleCreateAccount() {
        Task {
            do {
                try await auth.createUser(withEmail: email, password: password)
                guard let userId = auth.userSession?.uid else { return }
                
                let newUserProfile = User(
                    goal: onboardingViewModel.goal,
                    displayUnit: onboardingViewModel.displayUnit,
                    heightCm: onboardingViewModel.heightCm,
                    gender: onboardingViewModel.gender,
                    dateOfBirth: onboardingViewModel.dateOfBirth,
                    targetCalories: onboardingViewModel.calories,
                    targetProtein: onboardingViewModel.protein,
                    targetCarbs: onboardingViewModel.carbs,
                    targetFat: onboardingViewModel.fat
                )
                
                await profile.saveNewUserProfile(userId: userId, profileData: newUserProfile)
                
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
}

#Preview {
    CongratulationsView()
        .preferredColorScheme(.dark)
}
