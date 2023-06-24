//
//  HomeViewModel.swift
//  Nutrition
//
//  Created by kaiserdem  on 05.05.2023.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var ststistics: [StatisticModel] = [] // @Published наюлдвєм із іншого файлу
    @Published var allProducts: [ProductModel] = []
    @Published var allProductsToday: [EatenProduct] = []
    @Published var dayProductsWithData: [(ProductModel, DaysProductsModel)] = []
    @Published var filterProducts: [ProductModel] = []
    @Published var myParameters: [MyParametersModel] = []

    @Published var searchText: String = ""

    private let firebaseDataService = FirebaseDataService()
    private let statisticDataService = StatisticDataService()
    private let productDataService = ProductDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }

    func addSubscribers() {
        
        $searchText
            .combineLatest(productDataService.$allProducts)
            //.combineLatest(firebaseDataService.$products)
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

        ["DaysProducts", "DayStatistics", "MyParameters", "StatisticsEntity", "TotalStatistics"].forEach {
            statisticDataService.deleteAllData($0)
        }
    }
    
    func calculateStatictis() {
        guard let totalRatio = statisticDataService.totalStatistics.first else { return }
        
        var dayCalories: Double = 0
        var dayProductsMap: [EatenProduct] = []


        statisticDataService.daysProducts.forEach { dayProduct in
            
            if let currentProduct = productDataService.allProducts.first(where: { $0.name == dayProduct.name }) {
                
                let calloriesOfOneGramm = currentProduct.calories / 100
                
                dayCalories += (dayProduct.gram * calloriesOfOneGramm)
          
                dayProductsMap.append(EatenProduct(name: currentProduct.name,
                                                   date: dayProduct.date ?? Date(),
                                                   gram: dayProduct.gram,
                                                   carbohydrates: calloriesOfOneGramm * dayProduct.gram,
                                                   protein: (currentProduct.protein / 100) * dayProduct.gram,
                                                   fat: (currentProduct.fat / 100) * dayProduct.gram,
                                                   calories: (currentProduct.calories / 100) * dayProduct.gram,
                                                   type: currentProduct.type))
                
            }
        }

        let normCalories = totalRatio.calories
        let remainderCalories = totalRatio.calories - dayCalories
        
        ststistics = buildStatisticData(model: NutritionDataModel(normCalories: normCalories,
                                                                             currentCalories: dayCalories,
                                                                             remainderCalories: remainderCalories,
                                                                             other: 0000))
        allProductsToday = dayProductsMap
    }
        
    private func buildStatisticData(model: NutritionDataModel?) -> [StatisticModel] {
        var stats: [StatisticModel] = []
        
        guard let data = model else { return stats }

        let marketCap = StatisticModel(title: "Norm", value: String(format:"%.0f", data.normCalories))
        let volume = StatisticModel(title: "Current", value: String(format:"%.0f", data.currentCalories))
        let btcDominance = StatisticModel(title: "Remainder", value: String(format:"%.0f", data.remainderCalories))
        let portfolio = StatisticModel(title: "Portfolio Value", value: "$0.00", percentageChange: 0)
        stats.append(contentsOf: [marketCap, volume, btcDominance, portfolio])
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
        FPC(fat: (0.3 * calories) / 9,
            protein: (0.3 * calories) / 4,
            carbohydrates: (0.4 * calories) / 4)
    }
    
    func removeDaysProducts(_ entity: DaysProducts) {
        statisticDataService.removeDaysProducts(entity)
    }
}
