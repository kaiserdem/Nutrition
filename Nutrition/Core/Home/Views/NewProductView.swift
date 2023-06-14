//
//  NewProductView.swift
//  Nutrition
//
//  Created by kaiserdem  on 10.06.2023.
//

import SwiftUI
import Combine

struct NewProductView: View {
    
    @EnvironmentObject private var vm: HomeViewModel

    @State private var title = ""
    @State private var fieldValue: String = ""
    @State private var segmentationSelection : AddSection = .product
    @State private var selectedTypeOfProduct = TypeOfProduct.none
    
    @State private var nameProductValue = ""
    @State private var fatValue = ""
    @State private var proteinValue = ""
    @State private var carbohydratesValue = ""
    @State private var caloriesValue = ""
    @State private var gramsValue = ""
    
    @State var allProducts: [ProductModel] = []


    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            
            /// 1 Segment
            Picker("", selection: $segmentationSelection) {
                ForEach(AddSection.allCases, id: \.self) {
                    Text("Add \($0.rawValue)")
                }
            }.pickerStyle(SegmentedPickerStyle())
                .padding()
                      
            if segmentationSelection == .product {
                /// 2 Title
                Text(segmentationSelection.rawValue)
                    .font(.title)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.primary)
                    .animation(.none)
                
                /// 3 Product Name
                ZStack {
                    ItemProductView(title: "Product Name", description: "You will be able to search for a product by name you enter", keyboardType: .alphabet, value: $nameProductValue)
                }
                .padding(15)
                
                
                // 4 Fat Protein Carbohydrates
                HStack(alignment: .center, spacing: 10) {
                    ItemProductView(title: "Fat", description: "per 100 grams", value: $fatValue)
                    ItemProductView(title: "Protein", description: "per 100 grams", value: $proteinValue)
                    ItemProductView(title: "Carbohydrates", description: "per 100 grams", value: $carbohydratesValue)
                }
                .padding(.all)
                
                // 5 Calories Gramm Type
                HStack(alignment: .center, spacing: 10) {
                    
                    ItemProductView(title: "Calories", description: "per 100 grams", value: $caloriesValue)
                    ItemProductView(title: "Gramm", description: "consumed grams", value: $gramsValue)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Type")
                        Text("of product")
                            .font(.system(size: 12, weight: .medium, design: .default))
                            .foregroundColor(Color.theme.gray)
                            .animation(.none)
                        Picker("Type", selection: $selectedTypeOfProduct) {
                            ForEach(TypeOfProduct.allCases, id: \.self) {
                                Text($0.title)
                            }
                        }
                    }
                }
                .padding(.all)
                .frame(minWidth: 0, maxWidth: .infinity)
                
            }
            if segmentationSelection == .meal {
                Text("Add foods to compose a meal")
                    .font(.title)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.primary)
                    .animation(.none)
                
                SearchBarView(searchText: $vm.searchText)
                productsList
                }
            // 5 Save
            NutritionButton(title: segmentationSelection.titleSave, disabled: false, backgroundColor: .yellow, foregroundColor: .white) {
                                
                let newProduct = ProductModel(name: nameProductValue,
                                              carbohydrates: Double(caloriesValue) ?? .zero,
                                              protein: Double(proteinValue) ?? .zero,
                                              fat: Double(fatValue) ?? .zero,
                                              calories: Double(caloriesValue) ?? .zero,
                                              type: selectedTypeOfProduct.rawValue)
                                
                /// add new product and add day roduct
                vm.updateMyProducts(newProduct)
                vm.updateDaysProducts(DaysProductsModel(productId: "",
                                                        gram: Double(gramsValue) ?? .zero,
                                                        date: Date.now,
                                                        name: nameProductValue))
                
            }
            
            Spacer()
            
        }
        
    }
}

struct NewProductView_Previews: PreviewProvider {
    static var previews: some View {
        NewProductView()
    }
}

extension NewProductView {
        
    private var item: some View {
        VStack {
            Text(title)
            TextField("", text: $fieldValue)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .border(.secondary)
                .keyboardType(.numberPad)
            Text(fieldValue)
        }
    }
}



struct ItemProductView: View {

    @State var title: String = ""
    @State var description: String = ""
    @State var keyboardType: UIKeyboardType = .numberPad
    @Binding var value: String


    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
            Text(description)
                .font(.system(size: 12, weight: .medium, design: .default))
                .foregroundColor(Color.theme.gray)
                .animation(.none)
            TextField("", text: $value)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .border(.secondary)
                .keyboardType(keyboardType)
                .onChange(of: value) {
                    print($0)
                }
        }
    }
}

extension NewProductView {
    private var productsList: some View {
        List {
            ForEach(allProducts) { product in
                ProductRowView(product: product)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .listStyle(PlainListStyle())
    }
}
