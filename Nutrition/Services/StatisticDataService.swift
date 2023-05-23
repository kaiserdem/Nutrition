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
    private let entityName: String = "StatisticsEntity"
    
    
    @Published var statistics: [StatisticsEntity] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Error loading Core Data! \(error)")
            }
            self.getStatistics()
        }
    }
    
    private func getStatistics() {
        let request = NSFetchRequest<StatisticsEntity>(entityName: entityName)
        do {
            statistics = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching Portfolio Entities. \(error)")
        }
    }
}
