//
//  UserModel.swift
//  Meal Balance
//
//  Created by Jonathan Cheth on 7/13/25.
//

import Foundation
import FirebaseFirestore

struct User: Codable, Identifiable {
    @DocumentID var id: String?
    
    // User's Goal
    var goal: String
    var displayUnit: String
    
    // User's Biometrics
    var heightCm: Double
    var gender: String
    var dateOfBirth: Date
    
    // User's Calculated Targets
    var targetCalories: Int
    var targetProtein: Int
    var targetCarbs: Int
    var targetFat: Int
}
