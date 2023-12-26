//
//  MenuSelectedView.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 05/09/2023.
//

import SwiftUI

struct MenuSelectedView: View {


    var body: some View {
        Menu {
            Button(role: .destructive) {

            } label: {
                Section{
                    Text("Shampoo")
                }
            }
            Button(role: .none) {

            } label: {
                Section{
                    Text("Balm")
                }
            }
            Button(role: .none) {

            } label: {
                Section{
                    Text("hair dye")
                }
            }
            Button(role: .none) {

            } label: {
                Section{
                    Text("Wig")
                }
            }
            Button(role: .none) {

            } label: {
                Section{
                    Text("Others")
                }
            }
        }label: {
            Label("Select Product", systemImage: "ellipsis.circle")
                .frame(minWidth: 400 ,maxWidth: 600,minHeight: 36,maxHeight: 50)
                .background(Color.gray.opacity(0.1))

                .cornerRadius(9)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(lineWidth: 0.5)
                        .foregroundColor(.blue)
                        .shadow(color: Color.black.opacity(0.4),radius: 3,x: 1,y: 2)
                )
                .padding()
        }
        .padding()
    }
}


struct MenuSelectedView_Previews: PreviewProvider {
    static var previews: some View {
        MenuSelectedView()
    }
}
