//
//  ContentView.swift
//  Nutrition
//
//  Created by kaiserdem  on 05.05.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack(alignment: .top) {
            VStack {
                Text("норма")
                Text("2890")
                
            }
            VStack {
                Text("потреблено")
                Text("0")
                
            }
            VStack {
                Text("осталось")
                Text("2890")
                
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
