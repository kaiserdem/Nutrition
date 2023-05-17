//
//  PreviewProvider.swift
//  Nutrition
//
//  Created by kaiserdem  on 05.05.2023.
//

import Foundation
import SwiftUI

extension PreviewProvider {
    
    static var dev: DeveloperPreview {
        return DeveloperPreview.instance
    }
}

class DeveloperPreview {
    static let instance = DeveloperPreview()
    private init() {}
    
    let homeVM = HomeViewModel()
    
    let state1 = StatisticModel(title: "Market Cap", value: "$12.5Bn", percentageChange: 25.34)
    let state2 = StatisticModel(title: "Total Value", value: "$1.23Tr")
    let state3 = StatisticModel(title: "Portfolio Value", value: "$50.4k", percentageChange: -12.34)
    
    let product = ProductModel(name: "Арахис", calories: 26.2, protein: 45.3, fat: 9.9, carbohydrates: 555, type: "")
}

