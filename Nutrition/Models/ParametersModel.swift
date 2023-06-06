//
//  ParametersModel.swift
//  Nutrition
//
//  Created by kaiserdem  on 24.05.2023.
//

import Foundation

enum Gender: CaseIterable {
    case man
    case woman
    case none
    
    var title: String {
        switch self {
        case .man:
            return "Man"
        case .woman:
            return "Woman"
        case .none:
            return "Not chosen"
        }
    }

}
enum Activity: CaseIterable {
    case min
    case middle
    case hide
    case veryHide
    case none

    
    var title: String {
        switch self {
        case .min:
            return "Min"
        case .middle:
            return "Middle"
        case .hide:
            return "Hide"
        case .veryHide:
            return "Very hide"
        case .none:
            return "Not chosen"
        }
    }
}

enum Goal: CaseIterable {
    case loseWeight
    case keepWeight
    case gainWeight
    case none
    
    var title: String {
        switch self {
        case .loseWeight:
            return "Lose weight"
        case .keepWeight:
            return "Keep weight"
        case .gainWeight:
            return "Gain weight"
        case .none:
            return "Not chosen"
        }
    }
}

struct ParametersModel {
    let gender: Gender
    let activity: Activity
    let height: CGFloat
    let age: CGFloat
    let weight: CGFloat
    let goal: Goal
}

struct MyParametersModel: Identifiable, Codable {
    let id = UUID().uuidString
    let gender: String
    let activity: String
    let height: CGFloat
    let age: CGFloat
    let weight: CGFloat
    let goal: String
}
