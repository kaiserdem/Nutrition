//
//  TypeOfProduct.swift
//  Nutrition
//
//  Created by kaiserdem  on 11.06.2023.
//

import Foundation

enum TypeOfProduct : String, CaseIterable {
    case meat = "Meat"
    case fish = "Fish"
    case vegetables = "Vegetables"
    case fruits = "Fruits"
    case berries = "Berries"
    case nuts = "Nuts"
    case driedFruits = "Dried fruits"
    case dairyProducts = "Dairy products"
    case desserts = "Desserts"
    case sweets = "Sweets"
    case softDrinks = "Soft drinks"
    case alcohol = "Alcohol"
    case groats = "Groats"
    case sportNutrition = "Sport Nutrition"
    case none = "Not chosen"

    var title: String {
        switch self {
        case .meat:
            return "Mясо"
        case .fish:
            return "Рыба"
        case .vegetables:
            return "Овощи"
        case .fruits:
            return "Фрукты"
        case .berries:
            return "Ягоды"
        case .nuts:
            return "Орехи"
        case .driedFruits:
            return "Сухофрукты"
        case .dairyProducts:
            return "Молочные продукты"
        case .desserts:
            return "Десерты"
        case .sweets:
            return "Сладости"
        case .softDrinks:
            return "Безалкогольные напитки"
        case .alcohol:
            return "Алкоголь"
        case .groats:
            return "Крупа"
        case .sportNutrition:
            return "Спортивное питание"
        case .none:
            return ""
        }
    }
}
