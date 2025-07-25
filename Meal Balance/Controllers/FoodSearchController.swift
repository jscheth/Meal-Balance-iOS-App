//
//  FoodSearchViewController.swift
//  Meal Balance
//
//  Created by Jonathan Cheth on 7/20/25.
//

import Foundation

@MainActor
class FoodSearchController: ObservableObject {
    // These properties will be observed by the UI to show search results.
    @Published var searchText = ""
    @Published var apiSearchResults: [FoodItem] = []
    @Published var customFoodResults: [FoodItem] = []
    @Published var isLoading = false

    // --- MOCK API SEARCH ---
    // In a real app, this is where you would make a network request
    // to a service like Nutritionix or Edamam using your API key.
    private func searchFoodDatabaseAPI(query: String) async -> [FoodItem] {
        print("Searching public food database for: \(query)")
        
        // We simulate a network delay to mimic a real API call.
        try? await Task.sleep(nanoseconds: 500_000_000)
        
        // For now, we return mock data. Replace this with your real API call.
        let mockResults = [
            FoodItem(id: "api_apple", name: "Apple", calories: 95, protein: 0.5, carbs: 25, fat: 0.3),
            FoodItem(id: "api_chicken", name: "Chicken Breast", brand: "Generic", calories: 165, protein: 31, carbs: 0, fat: 3.6),
            FoodItem(id: "api_rice", name: "Brown Rice", brand: "Generic", calories: 215, protein: 5, carbs: 45, fat: 1.8)
        ]
        
        // Filter the mock data to simulate a real search.
        if query.isEmpty { return [] }
        return mockResults.filter { $0.name.lowercased().contains(query.lowercased()) }
    }

    // This function performs both the API search and the custom food search.
    func performSearch(userId: String, profileController: ProfileController) {
        guard !searchText.isEmpty else {
            apiSearchResults = []
            customFoodResults = []
            return
        }
        
        isLoading = true
        
        Task {
            // Perform both searches at the same time for better performance.
            async let apiResults = searchFoodDatabaseAPI(query: searchText)
            async let customResults = try? profileController.fetchCustomFoods(userId: userId, matching: searchText)
            
            // Wait for both searches to complete and then update the UI.
            self.apiSearchResults = await apiResults
            self.customFoodResults = (await customResults) ?? []
            self.isLoading = false
        }
    }
}
