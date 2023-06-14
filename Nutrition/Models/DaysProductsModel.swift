//
//  DaysProductsModel.swift
//  Nutrition
//
//  Created by kaiserdem  on 13.06.2023.
//

import Foundation

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
