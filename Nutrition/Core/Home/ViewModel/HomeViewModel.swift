//
//  HomeViewModel.swift
//  Nutrition
//
//  Created by kaiserdem  on 05.05.2023.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var ststistics: [StatisticModel] = []
    @Published var allProducts: [ProductModel] = []
    @Published var filterProducts: [ProductModel] = []
    @Published var searchText: String = ""

    private let productDataService = ProductDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }

    func addSubscribers() {
                
        ststistics = mapGlobalMarketData(marketDataModel: NutritionDataModel(normCalories: 2000, currentCalories: 1500, remainderCalories: 500, other: 43432))
        
        $searchText
            .combineLatest(productDataService.$allProducts)
            .map(filter)
            .sink { [weak self] returnedProducts in
                self?.allProducts = returnedProducts
            }
            .store(in: &cancellables)
        
        /*
        productDataService.$allProducts
            .receive(on: DispatchQueue.main)
            .sink { [weak self] returnedProducts in
                self?.allProducts = returnedProducts
            }
            .store(in: &cancellables)
        */
        
        //allProducts = allProductData()
                
//        $searchText
//            .combineLatest(productDataService.$allProducts)
//            .map {
//                guard self.searchText.isEmpty else {
//                    return self.allProducts
//                }
//
//                let lowecasedText = $0.lowercased()
//
//                return self.allProducts.filter { product in
//                    return product.name.lowercased().contains(lowecasedText)
//                }
//            .map(filterProducts)
//            .sink { [weak self] returnedProducts in
//                self?.allProducts = returnedProducts
//            }
        
        
        
        $searchText
        //productDataService.
//            .combineLatest(productDataService.$allProducts)
//            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
//            .map(filterProducts)
//            .sink { [weak self] returnedProducts in
//                self?.allProducts = returnedProducts
//            }
//            .store(in: &cancellables)
        
//
//        // updates coins
//        c
//            .combineLatest(coinDataService.$allCoins)
//            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main) // waiting 0.5 sec for launch next code
//            .map(filterCoins)
//            .sink { [weak self] returnedCoins in
//                self?.allCoins = returnedCoins
//            }
//            .store(in: &cancellables)
//z
//        // updates market data
//        marketDataService.$marketData
//            .map(mapGlobalMarketData)
//            .sink { [weak self] returnedStats in
//                self?.ststistics = returnedStats
//            }
//            .store(in: &cancellables)
    }
        private func filter(text: String, products: [ProductModel]) -> [ProductModel] {
            guard !text.isEmpty else {
                return products
            }
            
            let lowecasedText = text.lowercased()
            
            return products.filter { product in
                return product.name.lowercased().contains(lowecasedText)
            }
        }
        
    private func mapGlobalMarketData(marketDataModel: NutritionDataModel?) -> [StatisticModel] {
        var stats: [StatisticModel] = []
        
        guard let data = marketDataModel else {
            return stats
        }
        
        let marketCap = StatisticModel(title: "Norm", value: String(data.normCalories))
        let volume = StatisticModel(title: "Current", value: String(data.currentCalories))
        let btcDominance = StatisticModel(title: "Remainder", value: String(data.remainderCalories))
        let portfolio = StatisticModel(title: "Portfolio Value", value: "$0.00", percentageChange: 0)
        stats.append(contentsOf: [
            marketCap, volume, btcDominance, portfolio
        ])
        return stats
    }
}
