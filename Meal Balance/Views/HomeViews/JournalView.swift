//
//  JournalView.swift
//  Meal Balance
//
//  Created by Jonathan Cheth on 7/13/25.
//

import SwiftUI

struct JournalView: View {
    @EnvironmentObject var auth: AuthenticationController
    @EnvironmentObject var profile: ProfileController
    
    // Create an instance of the new JournalController.
    @StateObject private var journalController = JournalController()
    
    // This state will control the presentation of the "Add Food" sheet.
    @State private var isAddFoodSheetPresented = false
    // This will hold the meal type for which we are adding food.
    @State private var mealTypeToAdd: String?

    var body: some View {
        NavigationView {
            if let user = profile.user {
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        // --- My Macros Section ---
                        VStack(alignment: .leading) {
                            Text("My Macros").font(.title2).bold()
                            HStack {
                                // This now calculates the total macros from the journal entries.
                                let totals = calculateTotals()
                                MacroProgressView(label: "Protein", value: totals.protein, goal: user.targetProtein, color: .pink)
                                MacroProgressView(label: "Carbs", value: totals.carbs, goal: user.targetCarbs, color: .cyan)
                                MacroProgressView(label: "Fat", value: totals.fat, goal: user.targetFat, color: .green)
                                MacroProgressView(label: "kCal", value: totals.calories, goal: user.targetCalories, color: .orange)
                            }
                        }.padding()

                        // --- Meal Sections ---
                        // These now display real data from the JournalController.
                        MealSectionView(mealName: "Breakfast", entries: journalController.entriesByMeal["Breakfast"] ?? [], onAdd: { mealTypeToAdd = "Breakfast"; isAddFoodSheetPresented = true })
                        MealSectionView(mealName: "Lunch", entries: journalController.entriesByMeal["Lunch"] ?? [], onAdd: { mealTypeToAdd = "Lunch"; isAddFoodSheetPresented = true })
                        MealSectionView(mealName: "Dinner", entries: journalController.entriesByMeal["Dinner"] ?? [], onAdd: { mealTypeToAdd = "Dinner"; isAddFoodSheetPresented = true })
                        MealSectionView(mealName: "Snack", entries: journalController.entriesByMeal["Snack"] ?? [], onAdd: { mealTypeToAdd = "Snack"; isAddFoodSheetPresented = true })
                    }
                }
                .navigationTitle("Journal")
                .onAppear {
                    // When the view appears, fetch today's journal entries.
                    guard let userId = auth.userSession?.uid else { return }
                    Task {
                        await journalController.fetchJournalEntries(for: userId, on: Date())
                    }
                }
                .sheet(isPresented: $isAddFoodSheetPresented) {
                    // The sheet now presents the AddFoodView with the correct context.
                    AddFoodView(mealType: mealTypeToAdd ?? "Snack")
                }
            } else {
                ProgressView()
            }
        }
    }
    
    // A helper function to calculate the total macros consumed so far.
    private func calculateTotals() -> (calories: Int, protein: Int, carbs: Int, fat: Int) {
        let allEntries = journalController.entriesByMeal.values.flatMap { $0 }
        let totalCalories = allEntries.reduce(0) { $0 + Int($1.foodItem.calories) }
        let totalProtein = allEntries.reduce(0) { $0 + Int($1.foodItem.protein) }
        let totalCarbs = allEntries.reduce(0) { $0 + Int($1.foodItem.carbs) }
        let totalFat = allEntries.reduce(0) { $0 + Int($1.foodItem.fat) }
        return (totalCalories, totalProtein, totalCarbs, totalFat)
    }
}

// A helper view for each meal section, now displaying real data.
struct MealSectionView: View {
    let mealName: String
    let entries: [JournalEntry]
    let onAdd: () -> Void // This closure handles the tap on the "+" button.

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(mealName).font(.headline)
                Spacer()
                // The button now calls the onAdd closure.
                Button(action: onAdd) { Image(systemName: "plus.circle.fill").foregroundColor(.accentColor) }
            }
            Divider()
            
            if entries.isEmpty {
                Text("No foods logged for this meal.").font(.subheadline).foregroundColor(.secondary).padding(.vertical)
            } else {
                // List the food items that have been logged for this meal.
                ForEach(entries) { entry in
                    HStack {
                        Text(entry.foodItem.name)
                        Spacer()
                        Text("\(Int(entry.foodItem.calories)) cal")
                    }
                    .padding(.vertical, 4)
                }
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
        .padding(.horizontal)
    }
}
