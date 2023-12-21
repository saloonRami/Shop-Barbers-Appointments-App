//
//  AccountSetupView.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 03/11/2023.
//

import SwiftUI

struct AccountSetupView2: View {

    @State private var ProgressValue: Float = 0.0
    @State private var isLoading: Bool = false
    @State private var selectionTab = 0
    var body: some View {
        VStack{
            HeaderAccountSetup(ProgressValue: $ProgressValue,selectTab:$selectionTab)

            VStack {
                TabView(selection: $selectionTab) {

                    Text("What's your business name?")
                        .tag(0)

                    Text("What services do you offer?")
                        .tag(1)

                    Text("What's your team size?")
                        .tag(2)

                    Text("Set your location")
                        .tag(3)

                    Text(" Which software are you currently using?")
                        .tag(4)

                    Text("How did you hear about App?")
                        .tag(5)
                }
                .tabViewStyle(.page(indexDisplayMode: .automatic))
                .disabled(true)
            }.frame(minWidth: .zero,maxWidth: .infinity,minHeight: 200,maxHeight: .infinity)

            VStack{
                // Add Divider
                Divider()
                    .frame(height: 4)
                    .background(.gray.opacity(0.2))

                // Create Button
                Button(action: {
//                   self.isLoading = true
                    selectionTab = (selectionTab + 1) % 6
                    ProgressValue =  Float((Double(selectionTab) / 5.0))
                }, label: {
                    Text(self.isLoading ? "Loading......":"Next")
                            .frame(width: 320,height: 16)
                            .font(.title)
                            .bold()
                            .foregroundColor(.white)
                            .padding()
                            .background(.black)
                            .cornerRadius(16)

                }).fullScreenCover(isPresented: self.$isLoading){

                }
                .padding(.top)
            }
        }
    }
}

#Preview {
    AccountSetupView2()
}

