//
//  ProductsItems.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 03/09/2023.
//

import SwiftUI

struct ProductsItems: View {
    var Salons: SalonsModel

    var body: some View {
        VStack(alignment: .center) {
            Salons.image
                .renderingMode(.original)
                .resizable()
                .scaledToFit()
                .frame(width: 72, height: 72)
                .cornerRadius(5)
                .clipShape(Circle())
                .overlay {
                    Circle()
                        .stroke(.gray)
                        .shadow(radius: 7)
                }
                .padding()
            Text(Salons.name)
                .foregroundColor(.primary)
                .font(.title3)
                .fontWeight(.black)
                .shadow(radius: 7)

            Text(Salons.state)
                .foregroundColor(.primary)
                .font(.subheadline)
                .fontWeight(.black)
                .shadow(radius: 7)
                .padding(.bottom,2)
            VStack{
                HStack{
                    ForEach(0..<5){ item in
                        Image(systemName: item == 4 ? "star.leadinghalf.filled":"star.fill")
                            .disabled(true)
                            .foregroundColor(.orange)
                            .fixedSize()
                            .frame(width: 12,height: 12)
                    }
                    .padding(.vertical)
                    Text("4.5")
                        .foregroundColor(.primary)
                        .font(.subheadline)
                        .fontWeight(.black)
                        .shadow(radius: 7)
                        .padding(.leading,8)

                }
            }
        }
        .padding(.horizontal)
    }
}

struct ProductsItems_Previews: PreviewProvider {
    static var previews: some View {
        ProductsItems(Salons: ModelData().Salons[0])
    }
}
