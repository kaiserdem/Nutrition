//
//  CoinDataService.swift
//  Nutrition
//
//  Created by kaiserdem  on 06.05.2023.
//

import Foundation
import Combine

class ProductDataService {
    
    @Published var allProducts: [ProductModel] = []
    
    init() {
        getProducts()
    }
    
    private func getProducts() {
        
        allProducts = [
        ProductModel(name: "Арахис", calories: 26.2, protein: 45.3, fat: 9.9, carbohydrates: 555, type: ""),
        ProductModel(name: "Грецкий орех", calories: 31.5, protein: 61.5, fat: 10.6, carbohydrates: 662, type: ""),
        ProductModel(name: "Изюм с косточкой", calories: 1.7, protein: 0, fat: 70.7, carbohydrates: 273, type: ""),
        ProductModel(name: "Изюм кишмиш", calories: 2.5, protein: 0, fat: 71.4, carbohydrates: 285, type: ""),
        ProductModel(name: "Кешью", calories: 25, protein: 54, fat: 13, carbohydrates: 647, type: ""),
        ProductModel(name: "Курага", calories: 5.7, protein: 0, fat: 65, carbohydrates: 270, type: ""),
        ProductModel(name: "Миндаль", calories: 18.3, protein: 57.9, fat: 13.4, carbohydrates: 643, type: ""),
        ProductModel(name: "Семя подсолнечника", calories: 20.9, protein: 52.5, fat: 5.5, carbohydrates: 582, type: ""),
        ProductModel(name: "Урюк", calories: 5, protein: 5.2, fat: 0, carbohydrates: 67, type: ""),
        ProductModel(name: "Финики", calories: 2, protein: 0.4, fat: 70, carbohydrates: 277, type: ""),
        ProductModel(name: "Фисташки", calories: 20, protein: 50, fat: 7, carbohydrates: 555, type: ""),
        ProductModel(name: "Фундук", calories: 16, protein: 66, fat: 9, carbohydrates: 700, type: ""),
        ProductModel(name: "Чернослив", calories: 2.7, protein: 0, fat: 65, carbohydrates: 262, type: ""),
        ProductModel(name: "Яблоки сушенные", calories: 3.1, protein: 0, fat: 68.3, carbohydrates: 275, type: "")
        ]
    }
}
