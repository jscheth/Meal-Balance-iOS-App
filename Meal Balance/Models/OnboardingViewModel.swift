//
//  OnboardingViewModel.swift
//  Meal Balance
//
//  Created by Jonathan Cheth on 7/8/25.
//

import Foundation

class OnboardingViewModel: ObservableObject {
    // User's Goal
    @Published var goal: String = "Lose Weight"
    
    // This property stores the user's preferred unit for display.
    @Published var displayUnit: String = "lbs"
    
    // User's Biometrics (always stored in metric for consistent calculations)
    @Published var currentWeightKg: Double = 77.0
    @Published var desiredWeightKg: Double = 68.0
    @Published var heightCm: Double = 173.0
    @Published var gender: String = "Male"
    @Published var dateOfBirth: Date = Calendar.current.date(byAdding: .year, value: -30, to: Date())!
    
    // User's Lifestyle
    @Published var activityLevelMultiplier: Double = 1.2
    @Published var liftsWeights: Bool = false
    
    // Calculated Results
    @Published var calories: Int = 0
    @Published var protein: Int = 0
    @Published var carbs: Int = 0
    @Published var fat: Int = 0

    // The calculation logic remains the same, using metric units internally.
    func calculateMacros() {
        let age = Calendar.current.dateComponents([.year], from: dateOfBirth, to: Date()).year ?? 30
        let bmr = (gender == "Male")
            ? (10 * currentWeightKg + 6.25 * heightCm - 5 * Double(age) + 5)
            // For "Female" or "Other", use the female formula as a baseline.
            : (10 * currentWeightKg + 6.25 * heightCm - 5 * Double(age) - 161)
        
        let tdee = bmr * activityLevelMultiplier
        
        var targetCalories = tdee
        if goal == "Lose Weight" { targetCalories -= 500 }
        else if goal == "Gain Weight" { targetCalories += 300 }
        
        self.calories = Int(targetCalories)
        
        let proteinRatio = liftsWeights ? 0.35 : 0.30
        let carbsRatio = liftsWeights ? 0.35 : 0.40
        let fatRatio = 0.30
        
        self.protein = Int((targetCalories * proteinRatio) / 4)
        self.carbs = Int((targetCalories * carbsRatio) / 4)
        self.fat = Int((targetCalories * fatRatio) / 9)
    }
}
