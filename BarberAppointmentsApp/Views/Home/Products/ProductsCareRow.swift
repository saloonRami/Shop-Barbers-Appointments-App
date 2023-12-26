//
//  ProductsCareRow.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 15/09/2023.
//

import SwiftUI

struct ProductsCareRow: View {

    var ProductsName: String
    var items: [SalonsModel]
    var gridItemLayout3 = [GridItem(.adaptive(minimum: 50))]
    var sixColumnGrid: [GridItem] = Array(repeating: .init(.flexible()), count : 6)
     var gridItemLayout = [GridItem(.flexible()),
                                  GridItem(.flexible()),
                                  GridItem(.flexible())]
    var body: some View {
            VStack{
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .top, spacing: 0) {
                        ForEach(items,id:\.self) { item in
                            Text(item.name)                                .font(.system(size: 12))
                                .foregroundColor(.white)
                                .fontWeight(.black)
                                .padding()
                                .background(Color.black)
                                .cornerRadius(12)
                                .padding(6)
                                .shadow(color:.gray,radius: 7)
                        }
                    }
                }
                GeometryReader { proxy in
                    LazyVGrid(columns: columns(size: proxy.size),spacing: 20){
                        ForEach(items) { item in
                            ServiceCellStoreView(Services: item.name, size: proxy.size)
                        }
                    }
                    .padding()
                }
                .padding(.top)
            }
    }
    func columns(size: CGSize) -> [GridItem] {
      [
        GridItem(.adaptive(
          minimum: SettingsStore.thumbnailSize(size: size).width))
      ]
    }
}

#Preview {
    ProductsCareRow(ProductsName: "Hello", items: [SalonsModel]())
}

struct ProductsCareRow_Previews: PreviewProvider {
    static var previews: some View {
        ProductsCareRow(ProductsName: "Hello", items: [SalonsModel].init())
            .environmentObject(ModelData())
            .environmentObject(SettingStore())
    }
}
