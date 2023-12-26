//
//  SwiftUIView.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 05/09/2023.
//

import SwiftUI

struct ProductsTextFeildView: View {

    
     @Binding var TextFeildValue : String
    
    var imageIcon : String?
    var Name : String
    var keyboardEn : keyboardEnm

    var body: some View {
        VStack{
            HStack {
                Image(systemName: imageIcon ?? "")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 16,height: 16)
                    .clipShape(Circle())
                    .overlay{
                        Circle().stroke(.clear, lineWidth: 4)
                        
                    }
                    .shadow(radius: 5)
                Text(Name)
                    .font(.headline)
                    .bold()
                    .frame(alignment: .leading)
                    .lineLimit(0)
                    .bold()
                    .multilineTextAlignment(.leading)
                    .padding()
                Spacer()
            }
            .padding(.horizontal)
            
            VStack{
                
                TextField(Name, text: $TextFeildValue)
                    .font(.subheadline)
                    .bold()
                    .cornerRadius(.infinity)
                    .multilineTextAlignment(.leading)
                    .background(Color.white)
                    .keyboardType(keyboardEn.getKeyboard())
                    .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(lineWidth: 1.0)
                            .foregroundColor(.gray)
                            .shadow(color: Color.gray.opacity(0.7),radius: 3,x: 1,y: 2)
                    )
            }
        }
//        .padding(.horizontal)
    }
}

struct productsTextFeildView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsTextFeildView(TextFeildValue: .constant(""), imageIcon: "person.fill", Name: "Add producta", keyboardEn: .defaults)
    }
}
