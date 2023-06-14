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
                
                StatisticView(stat: buildStatistic(stat), isPresentedAdditioinal: isExcessCalories(stat))
                    .frame(width: UIScreen.main.bounds.width / 3, height: 56)
            }
        }
        .background(Color.theme.grayDoubleLite)

        .frame(width: UIScreen.main.bounds.width, alignment: showPortfolio ? .trailing : .leading)
    }
    
    func excessCalories(_ stat: StatisticModel) -> Double {
        if stat.title == StatisticType.remainder.rawValue  {
            
            let total = Double(vm.ststistics.first {
                $0.title == StatisticType.current.rawValue
            }?.value ?? "") ?? .zero
            
            return (Double(stat.value) ?? .zero) + total
        }
        return Double()
    }
    
    private func buildStatistic(_ stat: StatisticModel) -> StatisticModel {
        isExcessCalories(stat) ? StatisticModel(title: stat.title, value: String(excessCalories(stat))) : stat
    }
    
    private func isExcessCalories(_ stat: StatisticModel) -> Bool {
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
