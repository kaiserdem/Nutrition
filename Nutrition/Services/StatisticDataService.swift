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
    
    @Published var myParameters: [MyParameters] = []
    @Published var totalStatistics: [TotalStatistics] = []
    @Published var dayStatistics: [DayStatistics] = []

    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Error loading Core Data! \(error)")
            }
            self.getMyParameters()
            self.getTotalStatistics()
            self.getDayStatistics()
        }
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
    
    private func getDayStatistics() {
        let request = NSFetchRequest<DayStatistics>(entityName: dayStatisticEntityName)
        do {
            dayStatistics = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching Day Statistic Entities. \(error)")
        }
    }
    
    private func getTotalStatistics() {
        let request = NSFetchRequest<TotalStatistics>(entityName: totalStatisticEntityName)
        do {
            totalStatistics = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching Total Statistic Entities. \(error)")
        }
    }
    
    //problem with retrieving or writing statistics
    
    
    // MARK: - Update data
    
    func updateTotalFPCRatio(_ total: FPCRatio) {
        
        if let oldStatistics = totalStatistics.first {
            removeTotalStatistics(oldStatistics)
        }
        add(ratio: total)
    }
    
    
    func updateDayFPCRatio(_ day: FPCRatio) {
        
        if let oldStatistics = totalStatistics.first {
            removeTotalStatistics(oldStatistics)
        }
        add(ratio: day)
    }
    
    func updateMyParameters(_ parameters: MyParametersModel) {
        
        if let oldParameters = myParameters.first {
            removeMyParameters(oldParameters)
        }
        add(parameters: parameters)
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
    }
}
