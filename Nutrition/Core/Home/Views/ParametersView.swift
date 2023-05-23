//
//  ParametersView.swift
//  Nutrition
//
//  Created by kaiserdem  on 20.05.2023.
//

import SwiftUI
import Combine

struct ParametersView: View {
    
    @State private var selectedActivity = ""
    @State private var selectedHeight = ""
    @State private var selectedAge = ""
    @State private var selectedWeight = ""
    @State private var selectedGoal = ""

    let activity = ["min", "middle", "hide", "very hide"]
    let height = Array(130...220)
    let age = Array(18...80)
    let goal = ["lose weight", "keep weight", "gain weight"]


    
    var body: some View {
        NavigationView {
                    Form {
                        Section {
                            
                            Picker("Set activity", selection: $selectedActivity) {
                                ForEach(activity, id: \.self) {
                                    Text($0)
                                }
                            }
                            
                            Picker("Set height", selection: $selectedAge) {
                                ForEach(height, id: \.self) {
                                    Text(String($0))
                                }
                            }
                            
                            Picker("Set age", selection: $selectedAge) {
                                ForEach(age, id: \.self) {
                                    Text(String($0))
                                }
                            }
                            
                            Picker("Set goal", selection: $selectedGoal) {
                                ForEach(goal, id: \.self) {
                                    Text(String($0))
                                }
                            }
                            
                            TextField("Set weight", text: $selectedWeight)
                                .keyboardType(.numberPad)
                        }
                        Button {
                            print("save")
                        } label: {
                            Text("save")
                        }

                    }
                    .navigationTitle("Set my parameters")
                }
        }
}

struct ParametersView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            
            ParametersView()
        }
    }
}
