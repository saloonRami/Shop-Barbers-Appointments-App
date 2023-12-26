//
//  SwiftUIView.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 03/09/2023.
//

import SwiftUI

struct ServiceCellStoreView: View {
    let Services: String
    var size: CGSize = .zero
    
    var body: some View {
        ZStack{
            VStack{
                Group {
                    Text(Services)
                        .font(.headline)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .lineLimit(2)
                        .padding(.horizontal)
                }
            }
            .cornerRadius(10)
            .frame(
                width: SettingsStore.thumbnailSize(size: size).width,
                height: SettingsStore.thumbnailSize(size: size).height)
            .shadow(
                color: Color("shadow-color"),
                radius: 3,
                x: 0.0,
                y: 0.0)
        }
//        .background(Color.random())
        .cornerRadius(10)
    }
}

struct ServiceCellStoreView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceCellStoreView(Services: ModelData().Salons[1].services.first?.description ?? "")
    }
}
