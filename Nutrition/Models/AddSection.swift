//
//  AddSection.swift
//  Nutrition
//
//  Created by kaiserdem  on 11.06.2023.
//

import Foundation

enum AddSection : String, CaseIterable {
    case meal = "Meal"
    case product = "Product"
    //case newProduct = "New product"
    
    var titleSave: String {
        switch self {
        case .meal:
            return "Save today's meal"
        case .product:
            return "Save today's product"
//        case .newProduct:
//            return "Add new product"

        }
    }
    
    var titleHeader: String {
        switch self {
        case .meal:
            return "Save today's meal"
        case .product:
            return "Save today's product"
//        case .newProduct:
//            return "Add new product"

        }
    }
}
