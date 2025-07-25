//
//  Authentication.swift
//  Meal Balance
//
//  Created by Jonathan Cheth on 7/13/25.
//

import SwiftUI
import FirebaseAuth

@MainActor // Ensures UI updates happen on the main thread.
class AuthenticationController: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    
    init() {
        self.userSession = Auth.auth().currentUser
    }
    
    func signIn(withEmail email: String, password: String) async throws {
        try await Auth.auth().signIn(withEmail: email, password: password)
        self.userSession = Auth.auth().currentUser
    }
    
    func createUser(withEmail email: String, password: String) async throws {
        try await Auth.auth().createUser(withEmail: email, password: password)
        self.userSession = Auth.auth().currentUser
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
}
