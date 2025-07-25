//
//  DashboardView.swift
//  Meal Balance
//
//  Created by Jonathan Cheth on 7/13/25.
//

import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var profile: ProfileController

    var body: some View {
        NavigationView {
            // Check if the user profile has been loaded from Firestore.
            if let user = profile.user {
                ScrollView {
                    VStack(alignment: .leading, spacing: 25) {
                        Text("Welcome").font(.largeTitle).bold().padding(.horizontal)
                        
                        // Display the user's macro targets from their profile.
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Your Daily Targets").font(.headline)
                            HStack(spacing: 10) {
                                MacroCircleView(label: "Protein", value: "0g", goal: "\(user.targetProtein)g", color: .pink)
                                MacroCircleView(label: "Carbs", value: "0g", goal: "\(user.targetCarbs)g", color: .cyan)
                                MacroCircleView(label: "Fat", value: "0g", goal: "\(user.targetFat)g", color: .green)
                                MacroCircleView(label: "kCal", value: "0", goal: "\(user.targetCalories)", color: .orange)
                            }
                        }
                        .padding().background(Color(.secondarySystemBackground)).cornerRadius(12).padding(.horizontal)
                        
                    }
                }.navigationTitle("Dashboard")
            } else {
                // Show a loading indicator while the profile is being fetched.
                VStack {
                    ProgressView()
                    Text("Loading Your Profile...")
                        .foregroundColor(.secondary)
                        .padding(.top)
                }
                .navigationTitle("Dashboard")
            }
        }
    }
}



// A helper view for the macro circles on the dashboard.
struct MacroCircleView: View {
    let label: String
    let value: String
    let goal: String
    let color: Color

    var body: some View {
        VStack {
            ZStack {
                Circle().stroke(color.opacity(0.3), lineWidth: 5)
                Circle().trim(from: 0, to: 0.01)
                    .stroke(color, style: StrokeStyle(lineWidth: 5, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                VStack {
                    Text(value).font(.headline).bold()
                    Text(goal).font(.caption).foregroundColor(.secondary)
                }
            }
            Text(label).font(.footnote)
        }
    }
}

#Preview {
    DashboardView()
        .environmentObject(OnboardingViewModel())
        .preferredColorScheme(.dark)
}
