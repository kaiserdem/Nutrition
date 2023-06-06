//
//  NutritionDataModel.swift
//  Nutrition
//
//  Created by kaiserdem  on 05.05.2023.
//

import Foundation

struct NutritionDataModel: Codable {
    let normCalories: Double
    let currentCalories: Double
    var remainderCalories: Double
    let other: Double
}
