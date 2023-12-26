//
//  HeadBarberView.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 08/10/2023.
//

import SwiftUI

struct HeadBarberView:View{

    @State private var showPaymentForm = false
    @State var tilte:String
//    let modalContent: () -> Content

    var body: some View {
        VStack {
         
            VStack{
                Image("1")
                    .resizable()
                    .scaledToFit()
                    .frame(minWidth: 0,maxWidth: 64,minHeight: 64)
                    .clipShape(Circle())
                    .padding()
                    .overlay {
                        Circle()
                            .stroke(lineWidth: 3)
                            .foregroundColor(.blue.opacity(0.4))
                    }
                    .shadow(color: .gray.opacity(0.9), radius: 5)
            }.padding(.bottom,2)
            VStack(alignment: .center){
                Spacer()
                HStack(alignment: .center) {
                    Spacer()

                    VStack(alignment: .center) {
                        Text(Date.today.string(with: "EEEE, MMM d, yyyy"))
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text(tilte)
                            .font(.title)
                            .fontWeight(.black)
                    }

                    Spacer()
                }
            }
            .frame(height:100)
            .padding()
//            .background(.blue)
            .offset(y:-44)

        }
    }
}

#Preview {
    HeadBarberView(tilte: "Rami")
}


struct HeaderMenuBarberView<Content>: View where Content: View {

    @State private var ShowEdit = false
    @Binding var tilte:String

    let modalContent: () -> Content
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        HStack(alignment: .top){
            
            Button {
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "chevron.backward")
                    .font(.system(size: 24,weight: .black))
            }
            Spacer()
            
            VStack{
                Text(tilte)
                    .font(.subheadline)
                    .bold()
                    .padding(.bottom,-44)
                Text(Date.today.string(with: "EEEE, MMM d, yyyy"))
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.vertical)
            }
            Spacer()
            Button {
                self.ShowEdit = true
            } label: {
                Image(systemName: "plus")
                    .font(.system(size: 24,weight: .regular))
            }
            .fullScreenCover(isPresented: self.$ShowEdit, onDismiss: {
                self.ShowEdit = false
            }) {
                self.modalContent()
            }
        }
        .padding()
    }
}
