//
//  FirebaseDataService.swift
//  Nutrition
//
//  Created by kaiserdem  on 17.06.2023.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine
import SwiftUI
import Firebase
import FirebaseDatabase

class FirebaseDataService {
    
    private let path: String = "products"
    private let store = Firestore.firestore()
    @Published var products: [ProductModel] = []

    init() {
        get()
    }

    func get() {
        
        store.collection(path)
            .addSnapshotListener { querySnapshot, error in
                
                if let error = error {
                    print("Error getting product: \(error.localizedDescription)")
                    return
                }
                
                print("get from fb")
                self.products = querySnapshot?.documents.compactMap { document in
                    try? document.data(as: ProductModel.self)
                } ?? []
            }
    }

    
    func add(_ product: ProductModel) {
        
        do {
            _ = try store.collection(path).addDocument(from: product)
        } catch {
            fatalError("Unable to add product: \(error.localizedDescription).")
        }
    }
    
    func update(_ product: ProductModel) {
                
        do {
            try store.collection(path).document(product.id).setData(from: product)
        } catch {
            fatalError("Unable to update product: \(error.localizedDescription).")
        }
    }
    
    func remove(_ product: ProductModel) {
                
        store.collection(path).document(product.id).delete { error in
            if let error = error {
                print("Unable to remove product: \(error.localizedDescription)")
            }
        }
    }
    
}
