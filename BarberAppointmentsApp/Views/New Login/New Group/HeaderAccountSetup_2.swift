//
//  HeaderAccountSetup_2.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 03/11/2023.
//

import SwiftUI

struct HeaderAccountSetup_2: View {

    @Environment(\.presentationMode) var presentationMode

    @Binding var ProgressValue: Float
    @Binding var selectTab : Int

    var body: some View {

        VStack(alignment: .leading){

            HStack{
                Image(systemName:"arrow.backward")
                    .font(.headline)
                    .bold()
                    .onTapGesture {
                        
                        if selectTab == 0{
                            self.presentationMode.wrappedValue.dismiss()
                        }else{
                            selectTab = (selectTab - 1) % 6
                            ProgressValue =  Float((Double(selectTab) / 5.0))
                        }
                    }
                Spacer()

                Text("Add Business")
                    .font(.title2)
                    .bold()
                    .multilineTextAlignment(.center)
                Spacer()
                Text("LogOut")
                    .font(.headline)
                    .bold()
                    .foregroundColor(.accentColor)

            }.padding([.horizontal])
            ProgressView(value: ProgressValue)
                .progressViewStyle(.linear)
                .symbolVariant(.slash)
                .frame(minHeight: 2.0)

            VStack{
                Text("Account Setup View")
                    .font(.subheadline)
                    .multilineTextAlignment(.leading)
                    .bold()
                    .foregroundColor(.gray.opacity(0.8))
            }.padding([.leading, .bottom, .trailing])
                .padding(.top,4)
        }
    }
}

#Preview {
    HeaderAccountSetup_2(ProgressValue: .constant(0.4), selectTab: .constant(3))
}
