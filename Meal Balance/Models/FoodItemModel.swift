//
//  FoodItemModel.swift
//  Meal Balance
//
//  Created by Jonathan Cheth on 7/19/25.
//

import Foundation
import FirebaseFirestore

struct FoodItem: Codable, Identifiable {
    @DocumentID var id: String?
    var name: String
    var brand: String?
    var calories: Double
    var protein: Double
    var carbs: Double
    var fat: Double
}
