//
//  ProfileController.swift
//  Meal Balance
//
//  Created by Jonathan Cheth on 7/13/25.
//

import Foundation
import FirebaseFirestore

@MainActor
class ProfileController: ObservableObject {
    @Published var user: User?
    @Published var isLoading: Bool = false
    @Published var journalEntries: [JournalEntry] = []

    private let db = Firestore.firestore()
    
    // --- User Profile Functions ---
    func fetchUserProfile(userId: String) async { /* ... */ }
    func saveNewUserProfile(userId: String, profileData: User) async { /* ... */ }
    
    // --- Data Logging Functions ---
    func logWeight(userId: String, weightKg: Double) async throws { /* ... */ }
    func createCustomFood(userId: String, food: FoodItem) async throws { /* ... */ }
    func createMeal(userId: String, meal: MealModel) async throws { /* ... */ }
    func createRecipe(userId: String, recipe: RecipeModel) async throws { /* ... */ }
    
    // --- New Food Search Function ---
    
    // This function fetches custom foods from Firestore that match a search query.
    // This function fetches custom foods from Firestore that match a search query.
    func fetchCustomFoods(userId: String, matching query: String) async throws -> [FoodItem] {
        let snapshot = try await db.collection("users").document(userId).collection("customFoods").getDocuments()
        let allCustomFoods = snapshot.documents.compactMap { try? $0.data(as: FoodItem.self) }

        if query.isEmpty {
            return allCustomFoods
        } else {
            return allCustomFoods.filter { $0.name.lowercased().contains(query.lowercased()) }
        }
    }
    
    // This function saves a new food log to the user's journal in Firestore.
    func addJournalEntry(userId: String, food: FoodItem, mealType: String) async throws {
        let journalEntry = JournalEntry(
            foodItem: food,
            date: Date(),
            mealType: mealType
        )
        try db.collection("users").document(userId).collection("journalEntries").addDocument(from: journalEntry)
    }
}

// This is a new data model for a journal entry.
struct JournalEntry: Codable, Identifiable {
    @DocumentID var id: String?
    // We embed the FoodItem directly to simplify fetching.
    var foodItem: FoodItem
    var date: Date
    var mealType: String // e.g., "Breakfast", "Lunch"
}
