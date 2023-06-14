//
//  OptionsView.swift
//  Nutrition
//
//  Created by kaiserdem  on 11.06.2023.
//

import SwiftUI

struct OptionsView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @State private var showSetParameters: Bool = false
    @State private var showAlert = false

    
    var body: some View {
            ZStack {
                Color.white
                .sheet(isPresented: $showSetParameters, content:  {
                    ParametersView(isPresented: $showSetParameters)
                })
//                Color.white
//                .sheet(isPresented: $showSetParameters, content:  {
//                    ParametersView(isPresented: $showAddMealView)
//                })
//
//                .sheet(isPresented: $showNewProductView, content:  {
//                    NewProductView()
//                })
                
                VStack {
                    Spacer(minLength: 24)
                    Text("Options")
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(Color.theme.primary)
                        .animation(.none)
                    Spacer()
                    
                    List {
                        NutritionButton(title: "Change my parameters", disabled: false, backgroundColor: Color.theme.gray, foregroundColor: .white) {
                            showSetParameters.toggle()
                        }
                        
                        NutritionButton(title: "Сhange units", disabled: false, backgroundColor: Color.theme.primaryLite, foregroundColor: .white) {
                        }
                        
                        NutritionButton(title: "Clear all data", disabled: false, backgroundColor: .red, foregroundColor: .white) {
                            showAlert = true

                        }
                    }
                }
                
            }
            .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Вы хотите удалить всё?"),
                            message: Text("Все данные удаляться."),
                            primaryButton: .destructive(Text("Yes"), action: {
                                vm.removeAllData()
                            }),
                            secondaryButton: .default(Text("No"))
                        )
                    }
    }
}

struct OptionsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            OptionsView()
                .navigationBarHidden(true)
        }
        .environmentObject(dev.homeVM)
    }
}

    
//    private var allProductsList: some View {
//        List {
//            ForEach(vm.allProducts) { product in
//                ProductRowView(product: product)
//                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
//            }
//        }
//        .listStyle(PlainListStyle())
//    }

//}
