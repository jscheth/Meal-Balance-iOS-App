//
//  WeightEntryModel.swift
//  Meal Balance
//
//  Created by Jonathan Cheth on 7/19/25.
//

import Foundation
import FirebaseFirestore

struct WeightEntryModel: Codable, Identifiable {
    @DocumentID var id: String?
    var weightKg: Double
    var date: Date
}
