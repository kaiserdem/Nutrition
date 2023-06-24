//
//  HomeView.swift
//  Nutrition
//
//  Created by kaiserdem  on 05.05.2023.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject private var vm = HomeViewModel()
    
    @State private var showAddMeal: Bool = false
    @State private var showSetParameters: Bool = false
    @State private var showAddMealView: Bool = false
    @State private var showNewProductView: Bool = false
    @State private var showDate: Bool = false
    @State private var selectedDate = Date()
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
            ZStack {
                Color.white
                .sheet(isPresented: $showSetParameters, content:  {
                    ParametersView(isPresented: $showSetParameters)
                })
                
                .sheet(isPresented: $showNewProductView, content:  {
                    NewProductView(isPresented: $showNewProductView)
                })
                
                .sheet(isPresented: $showDate) {
                    VStack {
                        
                        Spacer()
                        
                        NutritionButton(title: "Back to today", disabled: false, backgroundColor: .green.opacity(0.95), foregroundColor: .white) {
                            showDate.toggle()
                        }
                        
                        Spacer()
                        
                        DatePicker("", selection: $selectedDate, in: ...Date(), displayedComponents: [.date])
                            .datePickerStyle(GraphicalDatePickerStyle())
                            .onChange(of: selectedDate) { newValue in
                                print("Name changed to \(selectedDate)!")
                                showDate.toggle()
                            }
                            
                        
                        Spacer()

                        NutritionButton(title: "Close", disabled: false, backgroundColor: .yellow, foregroundColor: .white) {
                            showDate.toggle()
                        }
                        Spacer()

                    }
                        
                }

                VStack {
                    homeHeader
                    Text(!showAddMeal ? "Calories" : "Search product")
                        .font(!showAddMeal ? .title2 : .title2)
                        .fontWeight(.medium)
                        .foregroundColor(Color.theme.primary)
                        .font(.system(size: 26, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .center)
            

                    if !showAddMeal {
                        VStack {
                            HomeStatsView(showPortfolio: $showAddMeal)

                            Text(!showAddMeal ? "My ete today" : "History")
                                .font(!showAddMeal ? .title3 : .title3)
                                .fontWeight(.medium)
                                .foregroundColor(Color.theme.primary)

                            allProductsTodayList
                        }
                        .transition(.move(edge: .leading))

                    } else {
                        VStack {
                            SearchBarView(searchText: $vm.searchText)
                                            
                            Text(!showAddMeal ? "My ete today" : "History")
                                .font(!showAddMeal ? .title3 : .title3)
                                .fontWeight(.medium)
                                .foregroundColor(Color.theme.primary)
                            
                            allProductsList
                        }
                        .transition(.move(edge: .trailing))
                    }
                }
            }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
                .navigationBarHidden(true)
        }
        .environmentObject(dev.homeVM)
    }
}

extension HomeView {

    private var homeHeader: some View {
        HStack {
            CircleButtonView(iconName: showAddMeal ? "plus" : "pencil")
                .rotationEffect(Angle(degrees: showAddMeal ? 180 : 0))
                .onTapGesture {
                    showAddMeal ? showNewProductView.toggle() : showSetParameters.toggle()
                }
                           
                .background(CircleButtonAnimationView(animate: $showAddMeal))
            Spacer()
            
            HStack {
                Text(showAddMeal ? "Add a meal" : "Today")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(Color.theme.primary)
                    .animation(.none)
            }
            .onTapGesture {
                if !showAddMeal {
                    showDate.toggle()
                }
            }
            Spacer()
            
            CircleButtonView(iconName: showAddMeal ? "chevron.right" : "plus")
                .rotationEffect(Angle(degrees: showAddMeal ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showAddMeal.toggle()
                    }
                }
        }
        //.padding(sides: [.left, .right], value: 10)

        //.padding(.horizontal)
    }
    
    private var allProductsList: some View {
        List {
            ForEach(vm.allProducts) { product in
                ProductRowView(product: product)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .listStyle(PlainListStyle())
    }
    
    private var allProductsTodayList: some View {
        List {
            ForEach(vm.allProductsToday) { product in
                ProductRowPreviewView(product: product)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .listStyle(PlainListStyle())
    }
    
    private func dismiss() {
        presentationMode.wrappedValue.dismiss()
      }

}
