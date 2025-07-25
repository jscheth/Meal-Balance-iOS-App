//
//  CreateMealView.swift
//  Meal Balance
//
//  Created by Jonathan Cheth on 7/19/25.
//

import SwiftUI

struct CreateMealView: View {
    // Connect to the app's controllers.
    @EnvironmentObject var auth: AuthenticationController
    @EnvironmentObject var profile: ProfileController
    @Environment(\.dismiss) var dismiss
    
    // State for the UI.
    @State private var mealName = ""
    // This is now an array of FoodItem objects to hold the real data.
    @State private var selectedFoods: [FoodItem] = []
    // This state controls the presentation of the food search sheet.
    @State private var isShowingFoodSearch = false

    var body: some View {
        VStack {
            Form {
                Section(header: Text("Meal Details")) {
                    TextField("Meal Name", text: $mealName)
                }
                
                Section(header: Text("Foods in this Meal")) {
                    // List the foods that have been added to the meal.
                    ForEach(selectedFoods) { food in
                        Text(food.name)
                    }
                    
                    // This button now presents the FoodSearchView as a sheet.
                    Button("Add Food...", action: {
                        isShowingFoodSearch = true
                    })
                }
            }
            
            // The save button is placed outside the form for better UI.
            Button(action: saveMeal) {
                Text("Save Meal")
                    .font(.headline).foregroundColor(.white)
                    .frame(maxWidth: .infinity).padding()
                    .background(mealName.isEmpty ? Color.gray : Color.blue)
                    .cornerRadius(12)
            }
            .disabled(mealName.isEmpty)
            .padding()
        }
        .navigationTitle("Create Meal")
        // This modifier presents the FoodSearchView when isShowingFoodSearch is true.
        .sheet(isPresented: $isShowingFoodSearch) {
            FoodSearchView { selectedFood in
                // This closure is called when a food is selected in the search view.
                self.selectedFoods.append(selectedFood)
                self.isShowingFoodSearch = false
            }
        }
    }
    
    private func saveMeal() {
        guard let userId = auth.userSession?.uid else { return }
        
        // This now maps the array of FoodItem objects to an array of their IDs for saving.
        let foodItemIDs = selectedFoods.compactMap { $0.id }
        
        let newMeal = MealModel(name: mealName, foodItems: foodItemIDs)
        
        Task {
            do {
                try await profile.createMeal(userId: userId, meal: newMeal)
                dismiss() // Close the view on success.
            } catch {
                print("Error saving meal: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    NavigationView {
        CreateMealView()
            .environmentObject(AuthenticationController())
            .environmentObject(ProfileController())
            .preferredColorScheme(.dark)
    }
}
