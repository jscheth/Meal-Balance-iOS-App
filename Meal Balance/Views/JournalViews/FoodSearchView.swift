//
//  FoodSearchView.swift
//  Meal Balance
//
//  Created by Jonathan Cheth on 7/13/25.
//

import SwiftUI


struct FoodSearchView: View {
    @Environment(\.dismiss) var dismiss
    // This closure is how the view communicates the selected food back to its parent.
    var onFoodSelected: (FoodItem) -> Void
    
    @State private var searchText = ""
    
    // Mock data for demonstration. A real app would fetch this from an API
    // and the user's custom food list in Firestore.
    let searchResults: [FoodItem] = [
        FoodItem(id: "food_1", name: "Apple", calories: 95, protein: 0.5, carbs: 25, fat: 0.3),
        FoodItem(id: "food_2", name: "Chicken Breast", brand: "Generic", calories: 165, protein: 31, carbs: 0, fat: 3.6),
        FoodItem(id: "food_3", name: "Brown Rice", brand: "Generic", calories: 215, protein: 5, carbs: 45, fat: 1.8),
        FoodItem(id: "food_4", name: "Broccoli", brand: "Generic", calories: 55, protein: 3.7, carbs: 11.2, fat: 0.6)
    ]

    var body: some View {
        NavigationView {
            List {
                ForEach(searchResults) { result in
                    Button(action: {
                        // When a food is tapped, call the closure with the selected item.
                        onFoodSelected(result)
                    }) {
                        VStack(alignment: .leading) {
                            Text(result.name).font(.headline)
                            Text("\(Int(result.calories)) calories, P: \(Int(result.protein))g, C: \(Int(result.carbs))g, F: \(Int(result.fat))g")
                                .font(.caption).foregroundColor(.secondary)
                        }
                    }
                    .buttonStyle(.plain) // Make the entire list row tappable.
                }
            }
            .navigationTitle("Food Search")
            .searchable(text: $searchText, prompt: "Search for a food")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }
}
