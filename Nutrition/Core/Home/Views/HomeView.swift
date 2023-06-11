//
//  HomeView.swift
//  Nutrition
//
//  Created by kaiserdem  on 05.05.2023.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @State private var showAddMeal: Bool = false
    @State private var showSetParameters: Bool = false
    @State private var showAddMealView: Bool = false
    @State private var showNewProductView: Bool = false

    
    var body: some View {
            ZStack {
                Color.white
                .sheet(isPresented: $showSetParameters, content:  {
                    ParametersView(isPresented: $showAddMealView)
                })
                
                .sheet(isPresented: $showNewProductView, content:  {
                    NewProductView()
                })
                
                
                VStack {
                    homeHeader
                    Button {
                        vm.removeAllData()
                    } label: {
                        Text("Clear all data")
                    }
                    
                    if !showAddMeal {
                        HomeStatsView(showPortfolio: $showAddMeal)
                            .transition(.move(edge: .leading))

                        Spacer(minLength: 10)
                        
                        Text(!showAddMeal ? "My ete today" : "History")
                            .font(!showAddMeal ? .title : .title3)
                            .fontWeight(.medium)
                            .foregroundColor(Color.theme.primary)
                            .animation(.none)
                        
                        allProductsTodayList
                            .transition(.move(edge: .leading))

                    } else {
                        SearchBarView(searchText: $vm.searchText)
                            .transition(.move(edge: .trailing))
                        
                        Spacer(minLength: 10)
                        
                        Text(!showAddMeal ? "My ete today" : "History")
                            .font(!showAddMeal ? .title : .title3)
                            .fontWeight(.medium)
                            .foregroundColor(Color.theme.primary)
                            .animation(.none)
                        
                        allProductsList
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
            
            Text(showAddMeal ? "Add a meal" : "Today")
                .font(.title)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.primary)
                .animation(.none)
            Spacer()
            
            CircleButtonView(iconName: showAddMeal ? "chevron.right" : "plus")
                .rotationEffect(Angle(degrees: showAddMeal ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showAddMeal.toggle()
                    }
                }
        }
        .padding(.horizontal)
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
            ForEach(vm.allProductsTodayModel) { product in
                ProductRowView(product: product)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .listStyle(PlainListStyle())
    }

}
