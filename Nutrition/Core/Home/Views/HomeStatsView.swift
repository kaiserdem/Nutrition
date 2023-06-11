//
//  HomeStatsView.swift
//  Nutrition
//
//  Created by kaiserdem  on 05.05.2023.
//

import SwiftUI


enum StatisticType: String, CaseIterable {
    case norm = "Norm"
    case current = "Current"
    case remainder = "Remainder"
}

struct HomeStatsView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @Binding var showPortfolio: Bool
    
    var body: some View {
        
        HStack {
            ForEach(vm.ststistics) { stat in
                                
                
                StatisticView(stat: statistic(stat), isPresentedAdditioinal: needAdditionalView(stat))
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
        }
        .background(Color.theme.grayDoubleLite)

        .frame(width: UIScreen.main.bounds.width, alignment: showPortfolio ? .trailing : .leading)
    }
    
    func setExtraValue(_ stat: StatisticModel) -> Double {
        if stat.title == StatisticType.remainder.rawValue {
            
            let a = vm.ststistics.first { $0.title == StatisticType.current.rawValue }
            let current: Double = Double(a!.value) ?? .zero
            let norm: Double = Double(stat.value) ?? .zero
            let extra = current - norm
            print(extra)
            return extra
        }
        return Double()
    }
    
    private func statistic(_ stat: StatisticModel) -> StatisticModel {
        
        if needAdditionalView(stat) {
            
            let value: String = String(setExtraValue(stat))
            
            return StatisticModel(title: stat.title, value: value)
            
        } else {
            return stat
        }
        
    }
    
    func needAdditionalView(_ stat: StatisticModel) -> Bool {
        if stat.title == StatisticType.remainder.rawValue {
            let a = Double(stat.value) ?? .zero
            return a <= 0
        }
        return false
    }
}

struct HomeStatsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeStatsView(showPortfolio: .constant(false))
            .environmentObject(dev.homeVM)
    }
}
