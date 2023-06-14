//
//  ProductRowPreviewView.swift
//  Nutrition
//
//  Created by kaiserdem  on 12.06.2023.
//

import SwiftUI

struct ProductRowPreviewView: View {
    
    let product: EatenProduct
    
    var body: some View {
        NavigationLink(destination: EditProductView(selectedDate: product.date.toString(dateFormat: "EEEE, MMM d, HH:mm"),
                                                    selectedWeight: String(product.gram),
                                                    fatValue: String(product.fat),
                                                    carbohydratesValue: String(product.carbohydrates),
                                                    proteinValue: String(product.protein),
                                                    caloriesValue: String(product.calories),
                                                    typeValue: product.type,
                                                    product: product)) {
            HStack(spacing: 0) {
                leftColumn
                Spacer()
            }
            .font(.subheadline)
        }
    }
}

struct ProductRowPreviewView_Previews: PreviewProvider {
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

extension ProductRowPreviewView {
    
    private var leftColumn: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(product.name.uppercased())
                    .font(.headline)
                    .padding(.leading, 6)
                    .foregroundColor(Color.primary)
                
                
            }
            
            HStack(alignment: .center) {
                Text("Б: \(String(format: "%.0f", product.protein)), У: \(String(format: "%.0f",product.carbohydrates)), Ж: \(String(format: "%.0f",product.fat)), Ккалл: \(String(format: "%.0f",product.calories)).")
                    .font(.caption)
                    .foregroundColor(Color.gray)
                    .frame(minWidth: 30)
                    .padding(.leading, 6)

                Spacer()
                Text("\(String(format: "%.0f", product.gram)) рамм")
                    .font(.system(size: 14))
                    //.padding(.trailing, 60)
                    .foregroundColor(Color.theme.blue)
                Spacer()

            }
        }
    }
}
