//
//  AddFoodView.swift
//  Meal Balance
//
//  Created by Jonathan Cheth on 7/13/25.
//

import SwiftUI

struct AddFoodView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var auth: AuthenticationController
    @EnvironmentObject var profile: ProfileController

    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 20) {
                // --- Main Action Buttons ---
                HStack(spacing: 15) {
                    // This now correctly initializes FoodSearchView with the required closure.
                    AddFoodActionGridItem(title: "Food Search", iconName: "magnifyingglass", destination: FoodSearchView(onFoodSelected: { selectedFood in
                        // This is the action that will be performed when a food is selected.
                        // For now, we'll assume it's for "Breakfast".
                        logFood(food: selectedFood, mealType: "Breakfast")
                    }))
                    AddFoodActionGridItem(title: "Scan Barcode", iconName: "barcode.viewfinder", destination: BarcodeScannerView())
                }
                HStack(spacing: 15) {
                    AddFoodActionGridItem(title: "Log Weight", iconName: "scalemass", destination: LogWeightView())
                    AddFoodActionGridItem(title: "AI Search", iconName: "sparkles", destination: AISearchView())
                }
                .padding(.bottom, 20)
                
                // --- List of Creation Options ---
                List {
                    NavigationLink(destination: CreateFoodView()) { Label("Create Food", systemImage: "plus.circle") }
                    NavigationLink(destination: CreateMealView()) { Label("Create Meal", systemImage: "plus.square.on.square") }
                    NavigationLink(destination: CreateRecipeView()) { Label("Create Recipe", systemImage: "text.book.closed") }
                }
                .listStyle(InsetGroupedListStyle())
            }
            .navigationTitle("Add to Journal")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
        .preferredColorScheme(.dark)
    }
    
    // Helper function to log the selected food to the journal.
    private func logFood(food: FoodItem, mealType: String) {
        guard let userId = auth.userSession?.uid else { return }
        Task {
            do {
                try await profile.addJournalEntry(userId: userId, food: food, mealType: mealType)
                dismiss() // Dismiss the main "Add to Journal" sheet after logging.
            } catch {
                print("Error logging food: \(error.localizedDescription)")
            }
        }
    }
}

// A helper view for the grid items on the AddFoodView.
struct AddFoodActionGridItem<Destination: View>: View {
    let title: String, iconName: String, destination: Destination
    @State private var isNavigationActive = false
    
    var body: some View {
        ZStack {
            NavigationLink(destination: destination, isActive: $isNavigationActive) { EmptyView() }.hidden()
            Button(action: { self.isNavigationActive = true }) {
                VStack {
                    Image(systemName: iconName).font(.largeTitle).padding(.bottom, 5)
                    Text(title).font(.caption)
                }
                .frame(maxWidth: .infinity, minHeight: 100)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(12)
            }
            .buttonStyle(.plain)
        }
    }
}
