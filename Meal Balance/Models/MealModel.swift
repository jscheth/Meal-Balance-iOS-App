//
//  MealModel.swift
//  Meal Balance
//
//  Created by Jonathan Cheth on 7/19/25.
//

import Foundation
import FirebaseFirestore

struct MealModel: Codable, Identifiable {
    @DocumentID var id: String?
    var name: String
    var foodItems: [String]
}
