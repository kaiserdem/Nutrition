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

    private let statisticDataService = StatisticDataService()
    private let productDataService = ProductDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }

    func addSubscribers() {
        
        guard let totalRatio = statisticDataService.totalStatistics.first else { return }
        
        let dayCalories = statisticDataService.dayStatistics.first?.calories ?? 0.0
        

        let normCalories = totalRatio.calories
        let currentCalories = dayCalories
        let remainderCalories = totalRatio.calories - currentCalories
        
        ststistics = mapGlobalMarketData(marketDataModel: NutritionDataModel(normCalories: normCalories,
                                                                             currentCalories: currentCalories,
                                                                             remainderCalories: remainderCalories,
                                                                             other: 43432))
        
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
    
    
    func updateTotalFPCRatio(_ ratio: FPCRatio) {
        statisticDataService.updateTotalFPCRatio(ratio)
    }
    
    func updateMyParameters(_ parameters: MyParametersModel) {
        statisticDataService.updateMyParameters(parameters)
    }
    
    
    /// Расчет калорийности по формуле Миффлина-Сан Жеора,
    /// ```
    /// Для женщин: (10 х вес в кг) + (6,25 х рост в см) – (5 х возраст в г) – 161
    /// Для мужчин: (10 х вес в кг) + (6,25 х рост в см) – (5 х возраст в г) + 5
    /// ```
    
    func calculateCalories(_ parameters: ParametersModel) -> CGFloat {
        
        print(parameters)
        let a = 10 * parameters.weight
        let b = 6.25 * parameters.height
        let c = 5 * parameters.age
        
        let result: CGFloat = a + b - c
        
        return parameters.gender == .man ? result + 5 : result - 161
    }
    
    func calulateFPC(_ calories: CGFloat) -> FPC {
        let fat = (0.3 * calories) / 9
        let protein = (0.3 * calories) / 4
        let carbohydrates = (0.4 * calories) / 4
        return FPC(fat: fat, protein: protein, carbohydrates: carbohydrates)
    }
}

struct FPC {
    let fat: CGFloat
    let protein: CGFloat
    let carbohydrates: CGFloat
}
