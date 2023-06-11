//
//  AddProductView.swift
//  Nutrition
//
//  Created by kaiserdem  on 07.06.2023.
//

import SwiftUI

struct AddProductView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var vm: HomeViewModel
    @State private var selectedWeight = ""
    
    let product: ProductModel
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        VStack {
                            
                            Text("data FPC calorie content per 100 grams of product")
                                .font(.footnote)
                            Spacer(minLength: 20)
                            
                            
                            ratio
                        }
                        TextField("weight gr", text: $selectedWeight)
                            .keyboardType(.numberPad)
                            .padding(10)
                            .pickerStyle(MenuPickerStyle())
                        
                    }
                }
                //Spacer(minLength: 30)
                Form {
                    Section {
                        Button(action: {
                            vm.updateDaysProducts(DaysProductsModel(productId: product.id, gram: Double(selectedWeight) ?? .zero, date: Date.now, name: product.name))
                            dismiss()
                        }, label: {
                            Text("Add Product")
                        })
                    }
                }
                .navigationTitle("Add Product")
            }
        }
    }
}

struct AddProductView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AddProductView(product: dev.product)
                .previewLayout(.sizeThatFits)
        }
    }
}

extension AddProductView {
    
    private func dismiss() {
        presentationMode.wrappedValue.dismiss()
      }
    
    private var ratio: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            Text(product.name.uppercased())
                .font(.headline)
                .padding(.leading, 6)
                .foregroundColor(Color.primary)
            
            Text("белок: \(String(format:"%.1f", product.protein)) углеводы: \(String(format:"%.1f",product.carbohydrates)), жир: \(String(format:"%.1f",product.fat)) калорийность: \(String(format:"%.1f",product.calories))")
                .font(.caption)
                .foregroundColor(Color.gray)
                .frame(minWidth: 30)
                .padding(.leading, 6)
            
            
        }
    }
}
