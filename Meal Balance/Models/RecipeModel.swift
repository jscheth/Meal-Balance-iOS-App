//
//  RecipeModel.swift
//  Meal Balance
//
//  Created by Jonathan Cheth on 7/19/25.
//

import Foundation
import FirebaseFirestore

struct RecipeModel: Codable, Identifiable {
    @DocumentID var id: String?
    var name: String
    var servings: Int
    var ingredients: [String]
}
