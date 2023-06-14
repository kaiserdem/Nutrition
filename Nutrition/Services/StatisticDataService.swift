//
//  StatisticDataService.swift
//  Nutrition
//
//  Created by kaiserdem  on 17.05.2023.
//

import Foundation
import CoreData

class StatisticDataService {
    
    private let container: NSPersistentContainer
    private let containerName: String = "StatisticsConteiner"
    private let myParametersEntityName: String = "MyParameters"
    private let totalStatisticEntityName: String = "TotalStatistics"
    private let dayStatisticEntityName: String = "DayStatistics"
    private let daysProductsEntityName: String = "DaysProducts"

    @Published var myParameters: [MyParameters] = []
    @Published var totalStatistics: [TotalStatistics] = []
    @Published var dayStatistics: [DayStatistics] = []
    @Published var daysProducts: [DaysProducts] = []

    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            
            if let error = error {
                print("Error loading Core Data! \(error)")
            }
            
            self.getMyParameters()
            self.getTotalStatistics()
            self.getDayStatistics()
            self.getDaysProducts()
        }
        debugPrint()
    }
    
    // MARK: - Get data

    private func getMyParameters() {
        let request = NSFetchRequest<MyParameters>(entityName: myParametersEntityName)
        
        do {
            myParameters = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching My Parameters Entities. \(error)")
        }
    }
    
    /// fpc of day
    private func getDayStatistics() {
        let request = NSFetchRequest<DayStatistics>(entityName: dayStatisticEntityName)
        
        do {
            dayStatistics = try container.viewContext.fetch(request)
            
            print(dayStatistics)
        } catch let error {
            print("Error fetching Day Statistic Entities. \(error)")
        }
    }
    
    /// main statistic by calculations of my parameters
    private func getTotalStatistics() {
        let request = NSFetchRequest<TotalStatistics>(entityName: totalStatisticEntityName)
        
        do {
            totalStatistics = try container.viewContext.fetch(request)
            print(totalStatistics)
        } catch let error {
            print("Error fetching Total Statistic Entities. \(error)")
        }
    }
    /// products eaten today
    private func getDaysProducts() {
        daysProducts.removeAll()
        
        let request = NSFetchRequest<DaysProducts>(entityName: daysProductsEntityName)
        
        do {
            let allTimesProducts = try container.viewContext.fetch(request)
            
            allTimesProducts.forEach {
                let dateString: String = $0.date!.toString(dateFormat: "yyyy-MM-dd")
                let today = Date().toString(dateFormat: "yyyy-MM-dd")
                
                if dateString == today { daysProducts.append($0) }
            }
            
        } catch let error {
            print("Error fetching Days Products Entities. \(error)")
        }
    }
        
    
    // MARK: - Update, save of data
    
    func updateTotalRatioFPC(_ total: FPCRatio) {
        
        if let oldStatistics = totalStatistics.first {
            removeTotalStatistics(oldStatistics)
        }
        add(ratio: total)
    }
    
    
    func updateDayRatioFPC(_ day: FPCRatio) {
        
        if let oldStatistics = dayStatistics.first {
            removeDayStatistics(oldStatistics)
        }
        add(ratio: day)
    }
    
    func updateMyParameters(_ parameters: MyParametersModel) {
        
        if let oldParameters = myParameters.first {
            removeMyParameters(oldParameters)
        }
        add(parameters: parameters)
    }
    
    func updateDaysProducts(_ product: DaysProductsModel) {
        add(daysProducts: product)
    }
    
    
    /// for adding TotalStatistics and DayStatistics
    private func add(ratio: FPCRatio) {
        let entity = TotalStatistics(context: container.viewContext)
        entity.carbohydrates = ratio.carbohydrates
        entity.protein = ratio.protein
        entity.fat = ratio.fat
        entity.calories = ratio.calories
        applyChanges()
    }
    
    private func add(parameters: MyParametersModel) {
        let entity = MyParameters(context: container.viewContext)
        entity.gender = parameters.gender
        entity.activity = parameters.activity
        entity.height = parameters.height
        entity.age = parameters.age
        entity.weight = parameters.weight
        entity.goal = parameters.goal
        applyChanges()
    }
    
    private func add(daysProducts: DaysProductsModel) {
        let entity = DaysProducts(context: container.viewContext)
        entity.date = daysProducts.date
        entity.gram = daysProducts.gram
        entity.productId = daysProducts.productId
        entity.name = daysProducts.name
        applyChanges()
    }
    
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving to Core Data. \(error)")
        }
    }
    
    private func applyChanges() {
        save()
        getDayStatistics()
        getMyParameters()
        getTotalStatistics()
        getDaysProducts()
        
        debugPrint()
    }
    
    // MARK: - Remove data
    
    private func removeTotalStatistics(_ entity: TotalStatistics) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    private func removeDayStatistics(_ entity: DayStatistics) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    private func removeMyParameters(_ entity: MyParameters) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    func deleteAllData(_ entity: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try container.viewContext.fetch(fetchRequest)
            
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                container.viewContext.delete(objectData)
            }
            
        } catch let error {
            print("Detele all data in \(entity) error :", error)
        }
        
        applyChanges()
    }
    
    private func debugPrint() {
        print("myParameters \(myParameters.count)")
        print("totalStatistics \(totalStatistics.count)")
        print("dayStatistics \(dayStatistics.count)")
        print("daysProducts \(daysProducts.count)")
    }
}
