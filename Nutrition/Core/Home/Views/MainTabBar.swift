//
//  MainTabBar.swift
//  Nutrition
//
//  Created by kaiserdem  on 11.06.2023.
//

import SwiftUI

struct MainTabBar: View {
    
    //var viewModel: MainTabBarViewModel
    
    let appearance: UITabBarAppearance = UITabBarAppearance()
    
    init() {
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
        
    var body: some View {
        
        TabView {
            
            NavigationView {
                HomeView()
            }
            .tabItem {
                VStack {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            }
            
            OptionsView()
                .tabItem {
                    VStack {
                        Image(systemName: "wrench")
                        Text("Options")
                    }
                }
        }
    }
}
