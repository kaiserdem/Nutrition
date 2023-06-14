//
//  ViewExtension.swift
//  Nutrition
//
//  Created by kaiserdem  on 13.06.2023.
//

import SwiftUI

enum Side: Equatable, Hashable {
    case left
    case right
}

extension View {
    func padding(sides: [Side], value: CGFloat = 8) -> some View {
        HStack(spacing: 0) {
            if sides.contains(.left) {
                Spacer().frame(width: value)
            }
            self
            if sides.contains(.right) {
                Spacer().frame(width: value)
            }
        }
    }
}
