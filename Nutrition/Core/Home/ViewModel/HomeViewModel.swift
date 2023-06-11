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
    @Published var allProductsTodayModel: [ProductModel] = []
    @Published var filterProducts: [ProductModel] = []
    @Published var myParameters: [MyParametersModel] = []



    @Published var searchText: String = ""

    private let statisticDataService = StatisticDataService()
    private let productDataService = ProductDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }

    func addSubscribers() {
        
        $searchText
            .combineLatest(productDataService.$allProducts)
            .map(filter)
            .sink { [weak self] returnedProducts in
                self?.allProducts = returnedProducts
            }
            .store(in: &cancellables)
        
        calculateStatictis()
        
        guard let parameters = statisticDataService.myParameters.first else { return }
        myParameters = [MyParametersModel(gender: parameters.gender ?? "",
                                         activity: parameters.activity ?? "",
                                         height: parameters.height,
                                         age: CGFloat(parameters.age),
                                         weight: CGFloat(parameters.weight),
                                         goal: parameters.goal ?? "")]
        
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
    
    func removeAllData() {
        productDataService.deleteAllData("MyProducts")
        statisticDataService.deleteAllData("DaysProducts")
        statisticDataService.deleteAllData("DayStatistics")
        statisticDataService.deleteAllData("MyParameters")
        statisticDataService.deleteAllData("StatisticsEntity")
        statisticDataService.deleteAllData("TotalStatistics")
        statisticDataService.deleteAllData("DaysProducts")
    }
    
    func calculateStatictis() {
        guard let totalRatio = statisticDataService.totalStatistics.first else { return }
        
        var dayCalories: Double = 0
        var dayProductsMap: [ProductModel] = []


        statisticDataService.daysProducts.forEach { dayProduct in
            
            if let currentProduct = productDataService.allProducts.first(where: { $0.name == dayProduct.name }) {
                
                let calloriesOfOneGramm = currentProduct.calories / 100
                dayCalories += (dayProduct.gram * calloriesOfOneGramm)
                
                dayProductsMap.append(ProductModel(name: currentProduct.name ?? "",
                                                  carbohydrates: calloriesOfOneGramm * dayProduct.gram,
                                                  protein: (currentProduct.protein / 100) * dayProduct.gram,
                                                  fat: (currentProduct.fat / 100) * dayProduct.gram,
                                                  calories: (currentProduct.calories / 100) * dayProduct.gram,
                                                  type: ""))
                
            }
        }

        let normCalories = totalRatio.calories
        let remainderCalories = totalRatio.calories - dayCalories
        
        ststistics = buildStatisticData(model: NutritionDataModel(normCalories: normCalories,
                                                                             currentCalories: dayCalories,
                                                                             remainderCalories: remainderCalories,
                                                                             other: 43432))
        
        
        
        
        allProductsTodayModel = dayProductsMap
    }
        
    private func buildStatisticData(model: NutritionDataModel?) -> [StatisticModel] {
        var stats: [StatisticModel] = []
        
        guard let data = model else {
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
        statisticDataService.updateTotalRatioFPC(ratio)
    }
    
    func updateMyParameters(_ parameters: MyParametersModel) {
        statisticDataService.updateMyParameters(parameters)
    }
    
    func updateDayFPCRatio(_ ratio: FPCRatio) {
        statisticDataService.updateDayRatioFPC(ratio)
    }
    
    func updateDaysProducts(_ product: DaysProductsModel) {
        statisticDataService.updateDaysProducts(product)
    }
    
    func updateMyProducts(_ product: ProductModel) {
        productDataService.updateMyProducts(product)
    }
    
    /// Расчет калорийности по формуле Миффлина-Сан Жеора,
    /// ```
    /// Для женщин: (10 х вес в кг) + (6,25 х рост в см) – (5 х возраст в г) – 161
    /// Для мужчин: (10 х вес в кг) + (6,25 х рост в см) – (5 х возраст в г) + 5
    /// ```
    
    func calculateCalories(_ parameters: Parameters) -> CGFloat {
        
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
