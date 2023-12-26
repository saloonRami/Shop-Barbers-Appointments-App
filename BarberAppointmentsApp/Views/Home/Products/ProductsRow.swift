//
//  ProductsRow.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 03/09/2023.
//

import SwiftUI

struct ProductsRow: View {
    var ProductsyName: String
    var items: [SalonsModel]

    var body: some View {
        VStack(alignment: .leading) {
            Text(ProductsyName)
                .font(.title)
                .fontWeight(.black)
                .foregroundColor(.black)
                .padding(.leading, 15)
                .padding(.top)
                .shadow(color:.gray,radius: 7)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {
                    ForEach(items) { landmark in
                        NavigationLink {
//                            SalonStoreView(items: landmark)
                        } label: {
                            ProductsItems(Salons: landmark)
                                .padding()
                        }
                    }
                }
                .frame(width: .infinity,height: .infinity)
            }
        }
        .frame(width: .infinity,height: .infinity)
    }
}

struct ProductsRow_Previews: PreviewProvider {
    static var landmarks = ModelData().Salons
    static var previews: some View {
        ProductsRow(ProductsyName: landmarks[0].category.rawValue,
                     items: Array(landmarks.prefix(4)))
    }
}
