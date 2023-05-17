//
//  HomeView.swift
//  Nutrition
//
//  Created by kaiserdem  on 05.05.2023.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @State private var showPortfolio: Bool = false
    @State private var showPortfolioView: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                    homeHeader
                if !showPortfolio {
                    HomeStatsView(showPortfolio: $showPortfolio)
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
            CircleButtonView(iconName: showPortfolio ? "plus" : "plus")
                //.animation(.none)
                .onTapGesture {
//                    if showPortfolio {
//                        showPortfolioView.toggle()
//                    }
                    withAnimation(.spring()) {
                        showPortfolio.toggle()
                    }
                }
                .background(
                    CircleButtonAnimationView(animate: $showPortfolio)
                )
            Spacer()
            Text(showPortfolio ? "Add a meal" : "Today")
                .font(.title)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.primary)
                .animation(.none)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPortfolio.toggle()
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

//    private var portfolioCoinsList: some View {
//        List {
//            ForEach(vm.portfolioCoins) { coin in
//                CoinRowView(coin: coin, showHoldingsColumn: true)
//                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
//            }
//        }
//        .listStyle(PlainListStyle())
//    }
    
//    private var columnTitles: some View {
//        HStack {
//            Text("Coin")
//            Spacer()
//            if showPortfolio {
//                Text("Holdigs")
//            }
//            Text("Prices")
//                .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
//        }
//        .font(.caption)
//        .foregroundColor(Color.theme.accent)
//        .padding(.horizontal)
//    }
    
}
