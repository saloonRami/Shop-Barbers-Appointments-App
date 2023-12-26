//
//  CreateProfileView.swift
//  BarberAppointmentsApp
//
//  Created by Rami Alaidy on 06/12/2023.
//

import Foundation
import SwiftUI

struct CreateProfileView: View {

    @State private var IfUpdatePassword : Bool = false
    @EnvironmentObject var VerfiyPhoneVM : VerifyPhoneViewModel
    @AppStorage("IsLogin") var IsLogin: Bool  = false

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Personal Information")) {

                    TextFieldCreateProfileView(NameProducts: self.$VerfiyPhoneVM.name,Name: "Enter Your Name", keyboardEn: .userName)
                    ////
                    TextFieldCreateProfileView(NameProducts: self.$VerfiyPhoneVM.email,Name: "Enter Your Email", keyboardEn: .email)

                    TextFieldCreateProfileView(NameProducts: self.$VerfiyPhoneVM.password,Name: "Enter Your Password", keyboardEn: .password)
                    //
//                                        TextFieldCreateProfileView(NameProducts: self.$VerfiyPhoneVM.UserId,Name: "Enter Your UserID", keyboardEn: .defaults)
                    //
                    //                    TextFieldCreateProfileView(NameProducts: self.$VerfiyPhoneVM.Uid,Name: "Enter Your Uid", keyboardEn: .defaults)

                }
                Button(action: {
                    self.VerfiyPhoneVM.UpdateUserProfile(self.VerfiyPhoneVM.name)
                    self.VerfiyPhoneVM.SetUserEmailAddress(email:   self.VerfiyPhoneVM.email)
                    self.IfUpdatePassword =  self.VerfiyPhoneVM.UpdatePassword(email:self.VerfiyPhoneVM.email, password: self.VerfiyPhoneVM.password)
                        self.VerfiyPhoneVM.GetUserProfile()

                }) {
                    Text("Update Profile")
                        .font(.system(size: 24,weight: .black))
                        .frame(width: 400,height: 60)
                        .bold()
                        .foregroundColor(.darkBlue)
                        .multilineTextAlignment(.center)
                }
                .fullScreenCover(isPresented: self.$IfUpdatePassword, content:{
//                    TabHomeView()
                })
                .navigationTitle(" Create Profile ")
            }
            .onAppear(){
//                self.VerfiyPhoneVM.GetUserProviderSpecificProfileInformation()
//                self.VerfiyPhoneVM.GetUserProfile()
            }
        }
    }
}

struct CreateProfileView_Previews: PreviewProvider {
    static var previews: some View {
        CreateProfileView()
            .environmentObject(VerifyPhoneViewModel())
    }
}
    struct TextFieldCreateProfileView: View {

        @Binding var NameProducts : String

        var Name : String
        var keyboardEn : keyboardEnm

        var body: some View {
            TextField(Name, text: $NameProducts)
                .font(.subheadline)
                .bold()
                .cornerRadius(.infinity)
                .multilineTextAlignment(.leading)
                .background(Color.white)
                .keyboardType(keyboardEn.getKeyboard())
                .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(lineWidth: 0.5)
                        .foregroundColor(.gray)
                        .shadow(color: Color.gray.opacity(0.4),radius: 3,x: 1,y: 2)
                )
        }
    }
