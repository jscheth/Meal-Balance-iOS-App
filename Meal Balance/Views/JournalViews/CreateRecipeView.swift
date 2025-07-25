//
//  CreateRecipeView.swift
//  Meal Balance
//
//  Created by Jonathan Cheth on 7/19/25.
//

import SwiftUI

struct CreateRecipeView: View {
    // Connect to the app's controllers.
    @EnvironmentObject var auth: AuthenticationController
    @EnvironmentObject var profile: ProfileController
    @Environment(\.dismiss) var dismiss
    
    // State for the UI.
    @State private var recipeName = ""
    @State private var servings = 4
    // This is now an array of FoodItem objects.
    @State private var ingredients: [FoodItem] = []
    // This state controls the presentation of the food search sheet.
    @State private var isShowingFoodSearch = false

    var body: some View {
        VStack {
            Form {
                Section(header: Text("Recipe Details")) {
                    TextField("Recipe Name", text: $recipeName)
                    // Use a stepper for a better user experience with numbers.
                    Stepper("Servings: \(servings)", value: $servings, in: 1...100)
                }
                
                Section(header: Text("Ingredients")) {
                    ForEach(ingredients) { ingredient in
                        Text(ingredient.name)
                    }
                    // This button now presents the FoodSearchView.
                    Button("Add Ingredient...", action: {
                        isShowingFoodSearch = true
                    })
                }
            }
            
            Button(action: saveRecipe) {
                Text("Save Recipe")
                    .font(.headline).foregroundColor(.white)
                    .frame(maxWidth: .infinity).padding()
                    .background(recipeName.isEmpty ? Color.gray : Color.blue)
                    .cornerRadius(12)
            }
            .disabled(recipeName.isEmpty)
            .padding()
        }
        .navigationTitle("Create Recipe")
        .sheet(isPresented: $isShowingFoodSearch) {
            FoodSearchView { selectedIngredient in
                self.ingredients.append(selectedIngredient)
                self.isShowingFoodSearch = false
            }
        }
    }
    
    private func saveRecipe() {
        guard let userId = auth.userSession?.uid else { return }
        
        // Map the array of ingredient FoodItems to an array of their IDs.
        let ingredientIDs = ingredients.compactMap { $0.id }
        
        let newRecipe = RecipeModel(name: recipeName, servings: servings, ingredients: ingredientIDs)
        
        Task {
            do {
                try await profile.createRecipe(userId: userId, recipe: newRecipe)
                dismiss() // Close the view on success.
            } catch {
                print("Error saving recipe: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    NavigationView {
        CreateRecipeView()
            .environmentObject(AuthenticationController())
            .environmentObject(ProfileController())
            .preferredColorScheme(.dark)
    }
}
