//
//  Product.swift
//  Nutrition
//
//  Created by kaiserdem  on 13.06.2023.
//

import Foundation


struct EatenProduct: Identifiable {
    let id = UUID().uuidString
    let name: String
    let date: Date
    let gram: Double
    let carbohydrates, protein, fat, calories: Double
    let type: String
   
    init(name: String, date: Date, gram: Double, carbohydrates: Double, protein: Double, fat: Double, calories: Double, type: String) {
        self.name = name
        self.date = date
        self.gram = gram
        self.carbohydrates = carbohydrates
        self.protein = protein
        self.fat = fat
        self.calories = calories
        self.type = type
    }
}
