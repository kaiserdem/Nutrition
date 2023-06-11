//
//  NewProductView.swift
//  Nutrition
//
//  Created by kaiserdem  on 10.06.2023.
//

import SwiftUI
import Combine

enum AddSection : String, CaseIterable {
    case meal = "Meal"
    case product = "Product"
    case newProduct = "New product"
    
    var titleSave: String {
        switch self {
        case .meal:
            return "Save today's meal"
        case .product:
            return "Save today's product"
        case .newProduct:
            return "Add new product"

        }
    }
    
    var titleHeader: String {
        switch self {
        case .meal:
            return "Save today's meal"
        case .product:
            return "Save today's product"
        case .newProduct:
            return "Add new product"

        }
    }
}

enum TypeOfProduct : String, CaseIterable {
    case meat = "Meat"
    case fish = "Fish"
    case vegetables = "Vegetables"
    case fruits = "Fruits"
    case berries = "Berries"
    case nuts = "Nuts"
    case dairyProducts = "Dairy products"
    case desserts = "Desserts"
    case sweets = "Sweets"
    case softDrinks = "Soft drinks"
    case alcohol = "Alcohol"
    case sportNutrition = "Sport Nutrition"
    case none = "Not chosen"

    var title: String {
        switch self {
        case .meat:
            return "Mясо"
        case .fish:
            return "Рыба"
        case .vegetables:
            return "Овощи"
        case .fruits:
            return "Фрукты"
        case .berries:
            return "ягоды"
        case .nuts:
            return "Орехи"
        case .dairyProducts:
            return "Молочные продукты"
        case .desserts:
            return "Десерты"
        case .sweets:
            return "Сладости"
        case .softDrinks:
            return "Безалкогольные напитки"
        case .alcohol:
            return "Алкоголь"
        case .sportNutrition:
            return "Спортивное питание"
        case .none:
            return ""
        }
    }
}

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

    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            
            // 1 Title
            Picker("", selection: $segmentationSelection) {
                ForEach(AddSection.allCases, id: \.self) {
                    Text("Add \($0.rawValue)")
                }
            }.pickerStyle(SegmentedPickerStyle())
                .padding()
                                 
            // 2
            Text(segmentationSelection.rawValue)
                .font(.title)
                .fontWeight(.medium)
                .foregroundColor(Color.theme.primary)
                .animation(.none)
            
            // 3 Product Name
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

                VStack {
                    Text("Type")
                    Picker("Type", selection: $selectedTypeOfProduct) {
                        ForEach(TypeOfProduct.allCases, id: \.self) {
                            Text($0.title)
                        }
                    }
                }
            }
            .padding(.all)
            
            // 5 Save
            LargeButton(title: segmentationSelection.titleSave, disabled: false, backgroundColor: .yellow, foregroundColor: .white) {
                
                print("save")
                
                let newProduct = ProductModel(name: nameProductValue,
                                              carbohydrates: Double(caloriesValue) ?? .zero,
                                              protein: Double(proteinValue) ?? .zero,
                                              fat: Double(fatValue) ?? .zero,
                                              calories: Double(caloriesValue) ?? .zero,
                                              type: selectedTypeOfProduct.rawValue)
                
                print(newProduct)
                
                vm.updateMyProducts(newProduct)
                vm.updateDaysProducts(DaysProductsModel(productId: "",
                                                        gram: Double(gramsValue) ?? .zero,
                                                        date: Date.now,
                                                        name: nameProductValue))
                
                // add new product
                // add day roduct
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
        }
    }
}


struct LargeButtonStyle: ButtonStyle {
    
    let backgroundColor: Color
    let foregroundColor: Color
    let isDisabled: Bool
    
    func makeBody(configuration: Self.Configuration) -> some View {
        let currentForegroundColor = isDisabled || configuration.isPressed ? foregroundColor.opacity(0.3) : foregroundColor
        return configuration.label
            .padding()
            .foregroundColor(currentForegroundColor)
            .background(isDisabled || configuration.isPressed ? backgroundColor.opacity(0.3) : backgroundColor)
            // This is the key part, we are using both an overlay as well as cornerRadius
            .cornerRadius(6)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(currentForegroundColor, lineWidth: 1)
        )
            .padding([.top, .bottom], 10)
            .font(Font.system(size: 19, weight: .semibold))
    }
}

struct LargeButton: View {
    
    private static let buttonHorizontalMargins: CGFloat = 20
    
    var backgroundColor: Color
    var foregroundColor: Color
    
    private let title: String
    private let action: () -> Void
    
    // It would be nice to make this into a binding.
    private let disabled: Bool
    
    init(title: String,
         disabled: Bool = false,
         backgroundColor: Color = Color.green,
         foregroundColor: Color = Color.white,
         action: @escaping () -> Void) {
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.title = title
        self.action = action
        self.disabled = disabled
    }
    
    var body: some View {
        HStack {
            Spacer(minLength: LargeButton.buttonHorizontalMargins)
            Button(action:self.action) {
                Text(self.title)
                    .frame(maxWidth:.infinity)
            }
            .buttonStyle(LargeButtonStyle(backgroundColor: backgroundColor,
                                          foregroundColor: foregroundColor,
                                          isDisabled: disabled))
                .disabled(self.disabled)
            Spacer(minLength: LargeButton.buttonHorizontalMargins)
        }
        .frame(maxWidth:.infinity)
    }
}
