//
//  CoinDataService.swift
//  Nutrition
//
//  Created by kaiserdem  on 06.05.2023.
//

import Foundation
import Combine
import CoreData

class ProductDataService {

    private let container: NSPersistentContainer
    private let containerName: String = "ProductsConteiner"
    private let myParoductsEntityName: String = "MyProducts"
    
    @Published var allProducts: [ProductModel] = []
    @Published var myProducts: [MyProducts] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            
            if let error = error {
                print("Error loading Core Data! \(error)")
            }
            
            self.getMyProducts()
        }
   
        getHardcodeProducts()
        mapAllProducts()
    }
    
    private func getMyProducts() {
        let request = NSFetchRequest<MyProducts>(entityName: myParoductsEntityName)
        
        do {
            print("get My Products")

            myProducts = try container.viewContext.fetch(request)
            print(myProducts.count)
        } catch let error {
            print("Error fetching my products Entities. \(error)")
        }
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
    
    private func getHardcodeProducts() {
        print("get Hardcode Products")
        allProducts = [
        ProductModel(name: "Арахис", carbohydrates: 26.2, protein: 45.3, fat: 9.9, calories: 555, type: ""),
        ProductModel(name: "Грецкий орех", carbohydrates: 31.5, protein: 61.5, fat: 10.6, calories: 662, type: ""),
        ProductModel(name: "Изюм с косточкой", carbohydrates: 1.7, protein: 0, fat: 70.7, calories: 273, type: ""),
        ProductModel(name: "Изюм кишмиш", carbohydrates: 2.5, protein: 0, fat: 71.4, calories: 285, type: ""),
        ProductModel(name: "Кешью", carbohydrates: 25, protein: 54, fat: 13, calories: 647, type: ""),
        ProductModel(name: "Курага", carbohydrates: 5.7, protein: 0, fat: 65, calories: 270, type: ""),
        ProductModel(name: "Миндаль", carbohydrates: 18.3, protein: 57.9, fat: 13.4, calories: 643, type: ""),
        ProductModel(name: "Семя подсолнечника", carbohydrates: 20.9, protein: 52.5, fat: 5.5, calories: 582, type: ""),
        ProductModel(name: "Урюк", carbohydrates: 5, protein: 5.2, fat: 0, calories: 67, type: ""),
        ProductModel(name: "Финики", carbohydrates: 2, protein: 0.4, fat: 70, calories: 277, type: ""),
        ProductModel(name: "Фисташки", carbohydrates: 20, protein: 50, fat: 7, calories: 555, type: ""),
        ProductModel(name: "Фундук", carbohydrates: 16, protein: 66, fat: 9, calories: 700, type: ""),
        ProductModel(name: "Чернослив", carbohydrates: 2.7, protein: 0, fat: 65, calories: 262, type: ""),
        ProductModel(name: "Яблоки сушенные", carbohydrates: 3.1, protein: 0, fat: 68.3, calories: 275, type: "") ]
    }
    
    private func mapAllProducts() {
        myProducts.forEach {
            allProducts.append(ProductModel(name: $0.name ?? "",
                                            carbohydrates: $0.carbohydrates,
                                            protein: $0.protein,
                                            fat: $0.fat,
                                            calories: $0.calories,
                                            type: $0.type ?? ""))
        
        }
    }
    
    func updateMyProducts(_ product: ProductModel) {
        add(prodyct: product)
    }
    
    private func add(prodyct: ProductModel) {
        let entity = MyProducts(context: container.viewContext)
        entity.name = prodyct.name
        entity.carbohydrates = prodyct.carbohydrates
        entity.protein = prodyct.protein
        entity.fat = prodyct.fat
        entity.calories = prodyct.calories
        entity.type = prodyct.type
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
        getMyProducts()
    }
}
