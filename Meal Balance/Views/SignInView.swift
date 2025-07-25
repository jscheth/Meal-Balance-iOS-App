//
//  SignInView.swift
//  Meal Balance
//
//  Created by Jonathan Cheth on 7/8/25.
//

import SwiftUI

struct SignInView: View {
    @EnvironmentObject var auth: AuthenticationController
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage: String?

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Spacer(minLength: 50)
                    Text("Meal Balance").font(.largeTitle).fontWeight(.bold)
                    TextField("Email", text: $email).textFieldStyle(RoundedBorderTextFieldStyle()).autocapitalization(.none).keyboardType(.emailAddress)
                    SecureField("Password", text: $password).textFieldStyle(RoundedBorderTextFieldStyle())
                    if let errorMessage = errorMessage { Text(errorMessage).foregroundColor(.red).font(.caption) }
                    Button(action: handleSignIn) {
                        Text("Sign In").font(.headline).foregroundColor(.white).frame(maxWidth: .infinity).padding().background(Color.blue).cornerRadius(12)
                    }
                    NavigationLink("Create Account", destination: WelcomeView())
                }.padding()
            }
            .navigationBarHidden(true)
            .background(Color.black.ignoresSafeArea())
        }
    }
    
    private func handleSignIn() {
        Task {
            do { try await auth.signIn(withEmail: email, password: password) }
            catch { errorMessage = error.localizedDescription }
        }
    }
}

#Preview {
    SignInView()
}
