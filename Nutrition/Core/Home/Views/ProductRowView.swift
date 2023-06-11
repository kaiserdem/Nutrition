//
//  ProductRowView.swift
//  Nutrition
//
//  Created by kaiserdem  on 06.05.2023.
//


import SwiftUI

struct ProductRowView: View {
    
    let product: ProductModel
    
    var body: some View {
        NavigationLink(destination: AddProductView(product: product)) {
            HStack(spacing: 0) {
                leftColumn
                Spacer()
    //            if showHoldingsColumn { centerColumn }
    //            rightColumn
            }
            .font(.subheadline)
        }
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ProductRowView(product: dev.product)
                .previewLayout(.sizeThatFits)
            ProductRowView(product: dev.product)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
            
        }
    }
}

extension ProductRowView {
    
    private var leftColumn: some View {
        VStack(alignment: .leading) {
            Text(product.name.uppercased())
                .font(.headline)
                .padding(.leading, 6)
                .foregroundColor(Color.primary)
            Text("белок: \(String(format:"%.1f", product.protein)) углеводы: \(String(format:"%.1f",product.carbohydrates)), жир: \(String(format:"%.1f",product.fat)) калорийность: \(String(format:"%.1f",product.calories))")
                .font(.caption)
                .foregroundColor(Color.gray)
                .frame(minWidth: 30)
                .padding(.leading, 6)

            
        }
    }
}
