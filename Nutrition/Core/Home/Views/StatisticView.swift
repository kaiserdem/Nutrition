//
//  StatisticView.swift
//  Nutrition
//
//  Created by kaiserdem  on 05.05.2023.
//

import SwiftUI

struct StatisticView: View {
    
    let stat: StatisticModel
    @State var isPresentedAdditioinal: Bool
    
    //String(format:"%.0f",stat.value)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(!isPresentedAdditioinal ? stat.title : "Excess calories")
                .font(.caption)
                .foregroundColor(Color.black)
            if !isPresentedAdditioinal {
                Text(stat.value)
                    .font(.headline)
                    .foregroundColor(Color.blue)
            } else {
                HStack(spacing: 4) {
                    
                    Image(systemName: "triangle.fill")
                        .font(.caption2)
                        .rotationEffect(Angle(degrees: (stat.percentageChange ?? 0) >= 0 ? 0: 180))
                    Text(stat.value)
                        .font(.headline)
                }
                .foregroundColor(Color.red)
                .opacity(1)
            }
        }
    }
}

struct StatisticView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticView(stat: dev.state1, isPresentedAdditioinal: true)
    }
}
