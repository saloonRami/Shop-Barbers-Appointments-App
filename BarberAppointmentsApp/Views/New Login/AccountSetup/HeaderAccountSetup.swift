//
//  HeaderAccountSetup.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 03/11/2023.
//

import SwiftUI

struct HeaderAccountSetup: View {

    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dissMiss
    @Binding var ProgressValue: Float
    @Binding var selectTab : Int

    @AppStorage("IsLogin") var IsLogin: Bool  = false
    @State var IsLogOut : Bool = false
    @EnvironmentObject var Vm: LoginEmailViewModel

    @State private var isselectTabZero : Bool = false
    @FocusState var isFocusedTextField: Bool
    
    var body: some View {

        VStack(alignment: .leading){

            HStack{
                Image(systemName: selectTab == 0 ? "":"arrow.backward")
                    .font(.headline)
                    .bold()

                    .onTapGesture {
                        if selectTab == 0{
                            self.presentationMode.wrappedValue.dismiss()
//                            self.isselectTabZero = true
                            self.isFocusedTextField = false
                        }else{
                            selectTab = (selectTab - 1) % 6
                            ProgressValue =  Float((Double(selectTab) / 5.0))
                            self.isselectTabZero = false
                            self.isFocusedTextField = false
                        }
                    }
                    .fullScreenCover(isPresented: $isselectTabZero , content: {
                        CreateBusinessView(VM: LoginEmailViewModel())
                    })
                Spacer()
                Text("Add Business")
                    .font(.title2)
                    .bold()
                    .multilineTextAlignment(.center)
                Spacer()

                Button {
                    self.Vm.Logout()
                    self.IsLogOut = true
//                    self.IsLogin.toggle()
                } label: {
                    Text("LogOut")
                }
                .fullScreenCover(isPresented: $IsLogOut) {
                    EmailCheckAndFetchView()
                }
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
            }.padding([.leading, .trailing])
                .padding(.top,4)
        }
    }
}

#Preview {
    HeaderAccountSetup(ProgressValue: .constant(0.4), selectTab: .constant(1))
}
