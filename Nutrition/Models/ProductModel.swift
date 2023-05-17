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
    let calories, protein, fat, carbohydrates: Double
    let type: String
}



