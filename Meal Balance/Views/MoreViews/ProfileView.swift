//
//  ProfileView.swift
//  Meal Balance
//
//  Created by Jonathan Cheth on 7/20/25.
//

import SwiftUI

struct ProfileView: View {
    // Connect to the Profile controller to get the user's data.
    @EnvironmentObject var profile: ProfileController
    
    // A helper to format the date of birth for display.
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }

    var body: some View {
        // A Form provides a standard iOS settings-style layout.
        Form {
            // Check if the user's profile data has been loaded.
            if let user = profile.user {
                Section(header: Text("Your Goal")) {
                    ProfileRow(label: "Primary Goal", value: user.goal)
                    ProfileRow(label: "Display Unit", value: user.displayUnit)
                }
                
                Section(header: Text("Your Biometrics")) {
                    ProfileRow(label: "Gender", value: user.gender)
                    ProfileRow(label: "Date of Birth", value: dateFormatter.string(from: user.dateOfBirth))
                    // Display height in the user's preferred unit.
                    if user.displayUnit == "lbs" {
                        let (feet, inches) = convertCmToFeetAndInches(user.heightCm)
                        ProfileRow(label: "Height", value: "\(feet) ft \(inches) in")
                    } else {
                        ProfileRow(label: "Height", value: "\(Int(round(user.heightCm))) cm")
                    }
                }
                
                Section(header: Text("Your Daily Targets")) {
                    ProfileRow(label: "Calories", value: "\(user.targetCalories) kcal")
                    ProfileRow(label: "Protein", value: "\(user.targetProtein) g")
                    ProfileRow(label: "Carbs", value: "\(user.targetCarbs) g")
                    ProfileRow(label: "Fat", value: "\(user.targetFat) g")
                }
            } else {
                // Show a message if the profile data is not yet available.
                Text("Loading profile...")
            }
        }
        .navigationTitle("Profile")
    }
    
    // A helper function to convert height from cm to feet and inches for display.
    private func convertCmToFeetAndInches(_ cm: Double) -> (feet: Int, inches: Int) {
        let totalInches = cm / 2.54
        let feet = Int(totalInches / 12)
        let inches = Int(round(totalInches.truncatingRemainder(dividingBy: 12)))
        return (feet, inches)
    }
}

// A reusable helper view for displaying a row of profile information.
struct ProfileRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
        }
    }
}

#Preview {
    NavigationView {
        ProfileView()
            .environmentObject(ProfileController())
            .preferredColorScheme(.dark)
    }
}
