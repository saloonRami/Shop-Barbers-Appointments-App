//
//  AddPasswordView.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 02/11/2023.
//

import SwiftUI

struct AddPasswordView: View {

     var email: String

    @State private var textValue: String = ""
    @State private var textName: String = "Password"
    @State private var isLoading: Bool = false

   @StateObject var  VM  = LoginEmailViewModel()

    @State private  var IsLogin: Bool  = false

    @State var IsEmptyData : Bool = false

    var body: some View {
        NavigationView(content: {
            VStack {

                HStack {
                    Text("Add PassWord For Email:")
                        .font(.caption)
                        .bold()
                    Text(email)
                        .font(.caption2)
                        .fontWeight(.heavy)
                        .bold()
                        .padding(.leading,-4)
                        .foregroundColor(.black)
                    Spacer()
                }.padding(.all)

                VStack {
                    CreateTextFeildCell(text: $textName, textValue: $VM.password)

                }.padding()

                Button(action: {
                    self.IsLogin = false
                    self.IsLogin = self.VM.LoginWithPassword(email:email,Password: VM.password)
                    self.isLoading = true
                }, label: {
                    Text(self.isLoading ? "Loading......":"Next")
                            .frame(width: 320,height: 16)
                            .font(.title)
                            .bold()
                            .foregroundColor(.white)
                            .padding()
                            .background(.black)
                            .cornerRadius(16)

                }).padding([.top,.bottom],100)
                    .fullScreenCover(isPresented: self.$IsLogin){
                        HomeTabMainView()
                    }
                    .disabled(VM.password.isEmpty ? true:false)
                    .opacity(VM.password.isEmpty ? 0.6:1.0)
                Spacer()
            } .navigationTitle("Add Password")
        })
    }
}

#Preview {
    AddPasswordView(email: "rami.alaidy@alaidy.com", VM: LoginEmailViewModel())
        .environmentObject(LoginEmailViewModel())
}
