//
//  StatisticModel.swift
//  Nutrition
//
//  Created by kaiserdem  on 05.05.2023.
//

import Foundation

struct StatisticModel: Identifiable {
    let id = UUID().uuidString
    let title: String
    let value: String
    let percentageChange: Double?
    
    init(title: String, value: String, percentageChange: Double? = nil) {
        self.title = title
        self.value = value
        self.percentageChange = percentageChange
    }
}

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

struct DaysProductsModel: Identifiable {
    let id = UUID().uuidString
    let productId: String
    let gram: Double
    let date: Date
    let name: String
   
    init(productId: String, gram: Double, date: Date, name: String) {
        self.gram = gram
        self.date = date
        self.productId = productId
        self.name = name
    }
}
