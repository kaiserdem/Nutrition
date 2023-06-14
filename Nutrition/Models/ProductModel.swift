//
//  ProductModel.swift
//  Nutrition
//
//  Created by kaiserdem  on 06.05.2023.
//

import Foundation

struct ProductModel: Identifiable, Codable {
    let id = UUID().uuidString
    let name: String
    let carbohydrates, protein, fat, calories: Double
    let type: String
    
    init(name: String, carbohydrates: Double, protein: Double, fat: Double, calories: Double, type: String) {
        self.name = name
        self.carbohydrates = carbohydrates
        self.protein = protein
        self.fat = fat
        self.calories = calories
        self.type = type
    }
}
