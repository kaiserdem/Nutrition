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
    
    var body: some View {
            ZStack {
                Color.white
                .sheet(isPresented: $showSetParameters, content:  {
                    ParametersView()
                })
                
                VStack {
                    homeHeader
                    if !showAddMeal {
                        HomeStatsView(showPortfolio: $showAddMeal)
                        Spacer(minLength: 10)
                        
                        Button(action: {
                            
                            showSetParameters.toggle()
                            
                        }) {
                            Text("Set statisic")
                                .fontWeight(.heavy)
                                .foregroundColor(Color.theme.primary)
                        }
                    } else {
                        SearchBarView(searchText: $vm.searchText)
                        allCoinsList
                            .transition(.move(edge: .leading))
                    }
                    Spacer(minLength: 0)
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
            CircleButtonView(iconName: showAddMeal ? "plus" : "plus")
                //.animation(.none)
                .onTapGesture {
                    print("showAddMeal: \(showAddMeal)")
                    print("showAddMealView: \(showAddMealView)")

                    if showAddMeal {
                        showAddMealView.toggle()
                    }
                    withAnimation(.spring()) {
                        showAddMeal.toggle()
                    }
                }
                .background(
                    CircleButtonAnimationView(animate: $showAddMeal)
                )
            Spacer()
            Text(showAddMeal ? "Add a meal" : "Today")
                .font(.title)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.primary)
                .animation(.none)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showAddMeal ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showAddMeal.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
    
    private var allCoinsList: some View {
        List {
            ForEach(vm.allProducts) { product in
                ProductRowView(product: product)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .listStyle(PlainListStyle())
    }

}
