//
//  CreateFoodView.swift
//  Meal Balance
//
//  Created by Jonathan Cheth on 7/19/25.
//

import SwiftUI

struct CreateFoodView: View {
    // Connect to the Authentication and Profile controllers from the environment.
    @EnvironmentObject var auth: AuthenticationController
    @EnvironmentObject var profile: ProfileController
    // This gives us the ability to dismiss the view programmatically.
    @Environment(\.dismiss) var dismiss
    
    // State variables to hold the user's input.
    @State private var foodName = ""
    @State private var brandName = ""
    // Use Double for numeric fields to match the FoodItem model.
    @State private var calories = 0.0
    @State private var protein = 0.0
    @State private var carbs = 0.0
    @State private var fat = 0.0

    var body: some View {
        Form {
            Section(header: Text("Food Details")) {
                TextField("Food Name", text: $foodName)
                TextField("Brand Name (Optional)", text: $brandName)
            }
            
            Section(header: Text("Nutrition Facts (per serving)")) {
                // These TextFields are now bound to Double values.
                TextField("Calories", value: $calories, format: .number)
                    .keyboardType(.decimalPad)
                TextField("Protein (g)", value: $protein, format: .number)
                    .keyboardType(.decimalPad)
                TextField("Carbs (g)", value: $carbs, format: .number)
                    .keyboardType(.decimalPad)
                TextField("Fat (g)", value: $fat, format: .number)
                    .keyboardType(.decimalPad)
            }
            
            // The button now calls the saveFood function.
            Button(action: saveFood) {
                Text("Save Food")
            }
        }
        .navigationTitle("Create Food")
    }
    
    // This function contains the logic to save the new food item.
    private func saveFood() {
        // 1. Get the current user's ID.
        guard let userId = auth.userSession?.uid else {
            print("Error: User not logged in.")
            return
        }
        
        // 2. Create a new FoodItem object from the user's input.
        let newFood = FoodItem(
            name: foodName,
            brand: brandName.isEmpty ? nil : brandName,
            calories: calories,
            protein: protein,
            carbs: carbs,
            fat: fat
        )
        
        // 3. Call the controller function to save the data to Firestore.
        Task {
            do {
                try await profile.createCustomFood(userId: userId, food: newFood)
                // 4. Dismiss the view on success.
                dismiss()
            } catch {
                print("Error saving custom food: \(error.localizedDescription)")
                // In a real app, you would show an error message to the user here.
            }
        }
    }
}

#Preview {
    // The preview needs the controllers to function correctly.
    NavigationView {
        CreateFoodView()
            .environmentObject(AuthenticationController())
            .environmentObject(ProfileController())
            .preferredColorScheme(.dark)
    }
}
