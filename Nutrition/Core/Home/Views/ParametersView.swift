//
//  ParametersView.swift
//  Nutrition
//
//  Created by kaiserdem  on 20.05.2023.
//

import SwiftUI
import Combine

struct ParametersView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @Binding var isPresented: Bool
    
    @State private var selectedGender = Gender.none
    @State private var selectedActivity = Activity.none
    @State private var selectedHeight: Int?
    @State private var selectedAge: Int?
    @State private var selectedWeight = ""
    @State private var selectedGoal = Goal.none
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    
                    Picker("Set gender", selection: $selectedGender) {
                        ForEach(Gender.allCases, id: \.self) {
                            Text($0.title)
                        }
                    }
                    .padding(5)
                    .pickerStyle(MenuPickerStyle())
                    
                    Picker("Set activity", selection: $selectedActivity) {
                        ForEach(Activity.allCases, id: \.self) {
                            Text($0.title)
                        }
                    }
                    .padding(5)
                    .pickerStyle(MenuPickerStyle())
                    
                    Picker("Set height", selection: $selectedHeight) {
                        Text("Not chosen").tag(nil as Int?)
                        
                        ForEach(140 ..< 200) {
                            Text(String($0) + " cm").tag($0 as Int?)
                        }
                        
                    }
                    .padding(5)
                    .pickerStyle(MenuPickerStyle())
                    
                    
                    Picker("Set age", selection: $selectedAge) {
                        Text("Not chosen").tag(nil as Int?)
                        
                        ForEach(13 ..< 80) {
                            Text(String($0) + " year").tag($0 as Int?)
                        }
                    }
                    .padding(5)
                    .pickerStyle(MenuPickerStyle())
                    
                    Picker("Set goal", selection: $selectedGoal) {
                        
                        ForEach(Goal.allCases, id: \.self) {
                            Text($0.title)
                        }
                    }
                    .padding(5)
                    .pickerStyle(MenuPickerStyle())
                    
                    TextField("Set weight", text: $selectedWeight)
                        .keyboardType(.numberPad)
                        .padding(10)
                        .pickerStyle(MenuPickerStyle())
                }
                Button {
                   
                    
                    guard let weight = NumberFormatter().number(from: selectedWeight) else { return }
                    
                    let calories = vm.calculateCalories(Parameters(gender: selectedGender,
                                                                        activity: selectedActivity,
                                                                        height: CGFloat(selectedHeight!),
                                                                        age: CGFloat(selectedAge!),
                                                                        weight: CGFloat(truncating: weight),
                                                                        goal: selectedGoal))
                    
                    let fpc = vm.calulateFPC(calories)
                    print(fpc)
                    print("calories: \(calories)")
                    
                    
                    /// update total statictic
                    vm.updateTotalFPCRatio(FPCRatio(calories: calories,
                                                     protein: fpc.protein,
                                                     fat: fpc.fat,
                                                     carbohydrates: fpc.carbohydrates))
                    
                    ///
                    vm.updateMyParameters(MyParametersModel(gender: selectedGender.title,
                                                            activity: selectedActivity.title,
                                                            height: CGFloat(selectedHeight!),
                                                            age: CGFloat(selectedAge!),
                                                            weight: CGFloat(truncating: weight),
                                                            goal: selectedGoal.title))
                    
                       
                    isPresented.toggle()

                } label: {
                    Text("Save")
                }
                
                Button {
                    isPresented.toggle()
                } label: {
                    Text("Cancel")
                }

            }
            .navigationTitle("Set my parameters")
        }
    }
}

struct ParametersView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            
            ParametersView(isPresented: .constant(false))
        }
    }
}
