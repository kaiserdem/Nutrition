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

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(stat.title)
                .font(.caption)
                .foregroundColor(Color.black)
            Text(isPresentedAdditioinal ? stat.value : "0")
                .font(.headline)
                .foregroundColor(Color.blue)
            
            
            if isPresentedAdditioinal {
                HStack(spacing: 4) {
                    
                    Image(systemName: "triangle.fill")
                        .font(.caption2)
                        .rotationEffect(Angle(degrees: (stat.percentageChange ?? 0) >= 0 ? 0: 180))
                    Text(stat.value)
                        .font(.caption)
                        .bold()
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
