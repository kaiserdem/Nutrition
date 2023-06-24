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
    
    private var cancellables = Set<AnyCancellable>()
    
    private let firebaseDS = FirebaseDataService()

    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            
            if let error = error {
                print("Error loading Core Data! \(error)")
            }
            
            self.getMyProducts()
            //self.getHardcodeProducts()
            //self.getFirestoreProducts()
            self.mapAllProducts()
            
        }
        //self.getFirestoreProducts()

        
//        $allProducts
//            .sink { _ in
//                print("sink")
//                print(self.allProducts.count)
//            }
        

    }
    
    private func getMyProducts() {
        let request = NSFetchRequest<MyProducts>(entityName: myParoductsEntityName)
        
        do {
            myProducts = try container.viewContext.fetch(request)
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
    
    private func getFirestoreProducts() {
        allProducts = firebaseDS.products
        
        allProducts
            
    }
    
    private func getHardcodeProducts() {
        print("get Hardcode Products")
        allProducts = [
            
            /// Орехи, Сухофрукты
            ProductModel(name: "Арахис", carbohydrates: 26.2, protein: 45.3, fat: 9.9, calories: 555, type: TypeOfProduct.nuts.title),
            ProductModel(name: "Грецкий орех", carbohydrates: 31.5, protein: 61.5, fat: 10.6, calories: 662, type: TypeOfProduct.nuts.title),
            ProductModel(name: "Изюм с косточкой", carbohydrates: 1.7, protein: 0, fat: 70.7, calories: 273, type: TypeOfProduct.driedFruits.title),
            ProductModel(name: "Изюм кишмиш", carbohydrates: 2.5, protein: 0, fat: 71.4, calories: 285, type: TypeOfProduct.nuts.title),
            ProductModel(name: "Кешью", carbohydrates: 25, protein: 54, fat: 13, calories: 647, type: TypeOfProduct.nuts.title),
            ProductModel(name: "Курага", carbohydrates: 5.7, protein: 0, fat: 65, calories: 270, type: TypeOfProduct.driedFruits.title),
            ProductModel(name: "Миндаль", carbohydrates: 18.3, protein: 57.9, fat: 13.4, calories: 643, type: TypeOfProduct.nuts.title),
            ProductModel(name: "Семя подсолнечника", carbohydrates: 20.9, protein: 52.5, fat: 5.5, calories: 582, type: TypeOfProduct.nuts.title),
            ProductModel(name: "Урюк", carbohydrates: 5, protein: 5.2, fat: 0, calories: 67, type: TypeOfProduct.driedFruits.title),
            ProductModel(name: "Финики", carbohydrates: 2, protein: 0.4, fat: 70, calories: 277, type: TypeOfProduct.driedFruits.title),
            ProductModel(name: "Фисташки", carbohydrates: 20, protein: 50, fat: 7, calories: 555, type: TypeOfProduct.nuts.title),
            ProductModel(name: "Фундук", carbohydrates: 16, protein: 66, fat: 9, calories: 700, type: TypeOfProduct.nuts.title),
            ProductModel(name: "Чернослив", carbohydrates: 2.7, protein: 0, fat: 65, calories: 262, type: TypeOfProduct.driedFruits.title),
            ProductModel(name: "Яблоки сушенные", carbohydrates: 3.1, protein: 0, fat: 68.3, calories: 275, type: TypeOfProduct.driedFruits.title),
            
            /// Алкогольные напитки
            ProductModel(name: "Бренди", carbohydrates: 1, protein: 0, fat: 0, calories: 225, type: TypeOfProduct.alcohol.title),
            ProductModel(name: "Вермут", carbohydrates: 15.9, protein: 0, fat: 0, calories: 155, type: TypeOfProduct.alcohol.title),
            ProductModel(name: "Вино сухое", carbohydrates: 0, protein: 0, fat: 0, calories: 66, type: TypeOfProduct.alcohol.title),
            ProductModel(name: "Вино полусухое", carbohydrates: 2.5, protein: 0.3, fat: 0, calories: 78, type: TypeOfProduct.alcohol.title),
            ProductModel(name: "Вино десертное", carbohydrates: 20, protein: 0.5, fat: 0, calories: 175, type: TypeOfProduct.alcohol.title),
            ProductModel(name: "Вино полусладкое", carbohydrates: 5, protein: 0.2, fat: 0, calories: 88, type: TypeOfProduct.alcohol.title),
            ProductModel(name: "Вино столовое", carbohydrates: 0.2, protein: 0.2, fat: 0, calories: 67, type: TypeOfProduct.alcohol.title),
            ProductModel(name: "Виски", carbohydrates: 0, protein: 0, fat: 0, calories: 222, type: TypeOfProduct.alcohol.title),
            ProductModel(name: "Водка", carbohydrates: 0.1, protein: 0, fat: 0, calories: 234, type: TypeOfProduct.alcohol.title),
            ProductModel(name: "Джин", carbohydrates: 0, protein: 0, fat: 0, calories: 223, type: TypeOfProduct.alcohol.title),
            ProductModel(name: "Коньяк", carbohydrates: 0.1, protein: 0, fat: 0, calories: 240, type: TypeOfProduct.alcohol.title),
            ProductModel(name: "Ликер", carbohydrates: 53, protein: 0, fat: 0, calories: 344, type: TypeOfProduct.alcohol.title),
            ProductModel(name: "Пиво 3,0%", carbohydrates: 3.5, protein: 0.6, fat: 0, calories: 37, type: TypeOfProduct.alcohol.title),
            ProductModel(name: "Пиво 4,5%", carbohydrates: 4.5, protein: 0.8, fat: 0, calories: 45, type: TypeOfProduct.alcohol.title),
            ProductModel(name: "Пиво темное", carbohydrates: 4, protein: 0.2, fat: 0, calories: 39, type: TypeOfProduct.alcohol.title),
            ProductModel(name: "Портвейн", carbohydrates: 13.8, protein: 0, fat: 0, calories: 167, type: TypeOfProduct.alcohol.title),
            ProductModel(name: "Ром", carbohydrates: 0, protein: 0, fat: 0, calories: 217, type: TypeOfProduct.alcohol.title),
            ProductModel(name: "Шампанское", carbohydrates: 5.2, protein: 0.3, fat: 0, calories: 88, type: TypeOfProduct.alcohol.title),
            
            /// Каши
            ProductModel(name: "Гречневая каша", carbohydrates: 27, protein: 4, fat: 1, calories: 137, type: TypeOfProduct.groats.title),
            ProductModel(name: "Кукурузные хлопья", carbohydrates: 83, protein: 6.5, fat: 3, calories: 83, type:TypeOfProduct.groats.title),
            ProductModel(name: "Манная каша", carbohydrates: 16, protein: 2.5, fat: 0.5, calories: 77, type:TypeOfProduct.groats.title),
            ProductModel(name: "Овсяная каша", carbohydrates: 15, protein: 3, fat: 2, calories: 93, type:TypeOfProduct.groats.title),
            ProductModel(name: "Овсяные хлопья", carbohydrates: 69, protein: 12, fat: 7, calories: 358, type: TypeOfProduct.groats.title),
            ProductModel(name: "Перловая каша", carbohydrates: 23, protein: 3, fat: 0.5, calories: 102, type: TypeOfProduct.groats.title),
            ProductModel(name: "Пшенная каша", carbohydrates: 17, protein: 3, fat: 0.8, calories: 92, type: TypeOfProduct.groats.title),
            ProductModel(name: "Рисовая каша", carbohydrates: 17.3, protein: 1.5, fat: 0.2, calories: 79, type: TypeOfProduct.groats.title),
            ProductModel(name: "Ячневая каша", carbohydrates: 18.7, protein: 1.4, fat: 0.3, calories: 84, type: TypeOfProduct.groats.title),
            ProductModel(name: "Ячневые хлопья", carbohydrates: 79.7, protein: 9.1, fat: 3.2, calories: 345, type: TypeOfProduct.groats.title)
        ]
    }
    
    private func mapAllProducts() {
        print("myProducts:\(myProducts.count)")
        print("allProducts:\(allProducts.count)")

                self.myProducts.forEach {
                    self.allProducts.append(ProductModel(name: $0.name ?? "",
                                                    carbohydrates: $0.carbohydrates,
                                                    protein: $0.protein,
                                                    fat: $0.fat,
                                                    calories: $0.calories,
                                                    type: $0.type ?? ""))
                }
        
        
//        if myProducts.isEmpty {
//           print("isEmpty")
//        } else {
//            print("not isEmpty")
//        }
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
