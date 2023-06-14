//
//  FPCRatio.swift
//  Nutrition
//
//  Created by kaiserdem  on 13.06.2023.
//

import Foundation

struct FPCRatio: Identifiable {
    let id = UUID().uuidString
    let calories: Double
    let protein: Double
    let fat: Double
    let carbohydrates: Double
    
    init(calories: Double, protein: Double, fat: Double, carbohydrates: Double) {
        self.calories = calories
        self.protein = protein
        self.fat = fat
        self.carbohydrates = carbohydrates

    }
}
