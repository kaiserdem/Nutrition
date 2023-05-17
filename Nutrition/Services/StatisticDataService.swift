//
//  StatisticDataService.swift
//  Nutrition
//
//  Created by kaiserdem  on 17.05.2023.
//

import Foundation
import Combine

class StatisticDataService {
    
    @Published var statistics : [ProductModel] = []
    
    init() {
        getProducts()
    }
    
    private func getProducts() {
        
       
    }
}
