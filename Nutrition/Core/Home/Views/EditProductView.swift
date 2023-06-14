//
//  EditProductView.swift
//  Nutrition
//
//  Created by kaiserdem  on 13.06.2023.
//

import SwiftUI

struct EditProductView: View {
    
    @Environment(\.presentationMode) var presentationMode

    @State private var selectedDate: String
    @State private var selectedNumberUnits: String
    @State private var fatValue: String
    @State private var carbohydratesValue: String
    @State private var proteinValue: String
    @State private var caloriesValue: String
    @State private var typeValue: String

    let product: EatenProduct
    
    init(selectedDate: String, selectedWeight: String, fatValue: String, carbohydratesValue: String, proteinValue: String, caloriesValue: String, typeValue: String, product: EatenProduct) {
        _selectedDate = State(initialValue: selectedDate)
        _selectedNumberUnits = State(initialValue: selectedWeight)
        _fatValue = State(initialValue: fatValue)
        _carbohydratesValue = State(initialValue: carbohydratesValue)
        _proteinValue = State(initialValue: proteinValue)
        _caloriesValue = State(initialValue: caloriesValue)
        _typeValue = State(initialValue: typeValue)
        self.product = product
    }

    var body: some View {
        VStack {
            Text(product.name)
                .font(.title)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.primary)
                        
            Spacer(minLength: 30)
            
            HStack(alignment: .center, spacing: 10) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Fat")
                    Text(String(product.fat))
                        .font(.system(size: 12, weight: .medium, design: .default))
                        .foregroundColor(Color.theme.primary)
                        .animation(.none)
                }
                Spacer()

                VStack(alignment: .leading, spacing: 10) {
                    Text("Protein")
                    Text(String(product.protein))
                        .font(.system(size: 12, weight: .medium, design: .default))
                        .foregroundColor(Color.theme.primary)
                        .animation(.none)
                }
                Spacer()

                VStack(alignment: .leading, spacing: 10) {
                    Text("Carbohydrates")
                    Text(String(product.carbohydrates))
                        .font(.system(size: 12, weight: .medium, design: .default))
                        .foregroundColor(Color.theme.primary)
                        .animation(.none)
                }
                Spacer()
                VStack(alignment: .leading, spacing: 10) {
                    Text("Calories")
                    Text(String(product.calories))
                        .font(.system(size: 12, weight: .medium, design: .default))
                        .foregroundColor(Color.theme.primary)
                        .animation(.none)
                }
            }.padding()
            
            
            VStack(alignment: .leading) {
                ItemProductView(title: "Change date of eaten", description: "date", keyboardType: .default, value: $selectedDate)
                        .padding()

                ItemProductView(title: "Change the number of grams eaten", description: "gramm eaten of meal", keyboardType: .default, value: $selectedNumberUnits)
                    .padding()
            }
            Spacer()
            Spacer()
            NutritionButton(title: "Save changes", disabled: false, backgroundColor: .yellow, foregroundColor: .white) {
                dismiss()
                // save update data of product
            }
            NutritionButton(title: "DELETE", disabled: false, backgroundColor: .red, foregroundColor: .white) {
                // remove product
            }
            
            Spacer()

        }
        
    }
}

struct EditProductView_Previews: PreviewProvider {
    static var previews: some View {
        EditProductView(selectedDate: "", selectedWeight: "", fatValue: "", carbohydratesValue: "", proteinValue: "", caloriesValue: "", typeValue: "", product: dev.editProduct)
    }
}


extension EditProductView {
    
    private func dismiss() {
        presentationMode.wrappedValue.dismiss()
      }
    
//    private var ratio: some View {
//        VStack(alignment: .leading, spacing: 10) {
//            
//            Text(product.name.uppercased())
//                .font(.headline)
//                .padding(.leading, 6)
//                .foregroundColor(Color.primary)
//            
//            Text("белок: \(String(format:"%.1f", product.protein)) углеводы: \(String(format:"%.1f",product.carbohydrates)), жир: \(String(format:"%.1f",product.fat)) калорийность: \(String(format:"%.1f",product.calories))")
//                .font(.caption)
//                .foregroundColor(Color.gray)
//                .frame(minWidth: 30)
//                .padding(.leading, 6)
//            
//            
//        }
//    }
}
