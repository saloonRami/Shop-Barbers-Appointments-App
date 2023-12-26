//
//  ServicesCellView.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 19/10/2023.
//

import SwiftUI

struct ServicesCellView: View {
    @Binding var data : String
    @Binding var isEditing: Bool
    @Binding var textPrice : String
    @Binding var textTime : String

    var body: some View {
        HStack(alignment: .center) {

            Text(data)
                .font(.headline)
                .bold()
                .onTapGesture {
                    print(ServicesMenu.init(rawValue: data)?.priceServices ?? "")
                }
            Spacer()
            if isEditing{
                Spacer()

                TextField("Price Service", text: self.$textPrice)
                    .font(.subheadline)
                    .bold()
                    .frame(minWidth: 36,maxWidth: 50)
                    .multilineTextAlignment(.center)
                    .overlay {
                        Rectangle().stroke().stroke(lineWidth: 2)
                            .foregroundColor(.gray.opacity(0.5))
                    }
//                    .onAppear(){
//                        self.managingServicesVM.PriceServices = self.text
//                    }
                Spacer()
                Text("JD /  ")
                    .font(.caption)
                    .bold()

                TextField("Time Service", text: self.$textTime)
                    .font(.subheadline)
                    .bold()
                    .frame(minWidth: 36,maxWidth: 64)
                    .multilineTextAlignment(.center)
                    .overlay {
                        Rectangle().stroke().stroke(lineWidth: 2)
                            .foregroundColor(.gray.opacity(0.5))
                    }
                Text("Minutes")
                    .font(.caption)
                    .bold()

            }else{
                Text("Price \(self.textPrice) JD")
                    .font(.caption)
                    .bold()
                Spacer()
                Text("Times \(self.textTime) Minutes")
                    .font(.caption)
                    .bold()
//                    .onAppear(){
//                        self.managingServicesVM.TimesServices = "\(ServicesMenu.init(rawValue: data)?.TimesServices ?? 0)"
//                    }
            }
        }
        .padding(.vertical)
    }
}



