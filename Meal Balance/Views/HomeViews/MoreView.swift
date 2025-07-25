//
//  MoreView.swift
//  Meal Balance
//
//  Created by Jonathan Cheth on 7/13/25.
//

import SwiftUI

struct MoreView: View {
    @EnvironmentObject var auth: AuthenticationController

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Account")) {
                    // This NavigationLink now points to the new ProfileView.
                    NavigationLink(destination: ProfileView()) {
                        Label("Profile", systemImage: "person.fill")
                    }
                    NavigationLink(destination: Text("Subscription Screen")) {
                        Label("Subscription", systemImage: "creditcard.fill")
                    }
                }
                
                Section(header: Text("Settings")) {
                    NavigationLink(destination: Text("Display Settings")) {
                        Label("Display", systemImage: "paintbrush.fill")
                    }
                    NavigationLink(destination: Text("Integrations Screen")) {
                        Label("Integrations", systemImage: "link")
                    }
                }

                Section {
                    Button(action: {
                        auth.signOut()
                    }) {
                        Text("Logout")
                            .foregroundColor(.red)
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("More")
        }
    }
}

#Preview {
    MoreView()
        .environmentObject(AuthenticationController())
        .environmentObject(ProfileController())
        .preferredColorScheme(.dark)
}
