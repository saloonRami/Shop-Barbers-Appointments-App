//
//  CreateBusinessView.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 02/11/2023.
//

import SwiftUI

struct CreateBusinessView: View {

    @Environment(\.presentationMode) var presentationMode
   @State var email: String = ""
   @State private var textName: [String] = ["First name","Last name","Password","Mobile number","Country"]

    @StateObject  var VM : LoginEmailViewModel
    @EnvironmentObject  var VerfiyPhoneVM : VerifyPhoneViewModel
    @State private var isLoading: Bool = false

    @State private var isCheckPrivacy: Bool = false

    @State var emailText: [String] = Array(repeating: "", count: 5)

    @State var IsEmptyData : Bool = false

    @State var IsVerfiyPhoneNumber: Bool = false

    var body: some View {

        NavigationStack{


            // Header View
            VStack(alignment: .center) {
                VStack(alignment: .leading,spacing: 8) {

                    HStack(alignment: .center, spacing: 10.0) {

                        Button {
                            self.presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image(systemName:"arrow.backward")
                                .font(.headline)
                                .bold()
                        }

                        Text("Create a business account")
                            .font(.title3)
                            .bold()
                            .multilineTextAlignment(.center)
                    }
                    Text("You're almost there! Create your new account for \(VM.email) by completing these details.")
                        .font(.caption)
                        .foregroundColor(.gray.opacity(1.0))
                        .bold()
                        .multilineTextAlignment(.leading)

                }.padding(.bottom)

                // Add Text Feild
                VStack{
                    ForEach(self.$textName.indices,id: \.self) { index in
                        if index == 3{
                            VStack{
                                PhoneNumberView(PhoneNumber: $VerfiyPhoneVM.PhoneNumber, Name: $textName[3], keyboardEn: .defaults)

                                RequirementTextView(iconName: "lock",iconColor:  Color(red: 251/255, green: 128/255, blue: 128/255),text: "It must contain 9 numbers", textSecandary: "Add your phone number without the first zero",isStrikeThrough:VerfiyPhoneVM.isPhoneNumber,textThrough:self.VerfiyPhoneVM.IsFirstIndexPhoneZero)

                            }.padding(.bottom)
                        }else{
                            VStack(alignment: .leading, spacing: 8) {
                            CreateTextFeildCell(text: $textName[index], textValue: $emailText[index])
                                if index == 2 {
                                    VStack {

                                        RequirementTextView(iconName: "lock.open", iconColor: VM.isPasswordLengthValid ? Color.secondary : Color(red: 251/255, green: 128/255, blue: 128/255),text: "It must contain 9 numbers", textSecandary: "Add your phone number without the first zero", isStrikeThrough: VM.isPasswordLengthValid)

                                        RequirementTextView(iconName: "lock.open", iconColor: VM.isPasswordCapitalLetter ? Color.secondary : Color(red: 251/255, green: 128/255, blue : 128/255), text: "One uppercase letter", isStrikeThrough: VM.isPasswordCapitalLetter)
                                    }
                                }
                            }
                        }
                    }
                }.padding(.vertical)

                // Check Privacy
                VStack {
                    HStack{

                        Image(systemName: self.isCheckPrivacy ? "checkmark.square.fill":"square")
                            .font(.title)
                            .bold()
                            .foregroundColor(.purple)
                            .padding(.leading,-4)
                            .onTapGesture {
                                self.isCheckPrivacy.toggle()
                            }

                        Text("agree to the Privacy Policy, Terms of Service and Terms of Business.")
                            .font(.subheadline)
                            .bold()
                            .foregroundColor(.black)
                            .lineLimit(2)
                            .multilineTextAlignment(.leading)
                            .padding()
                    }.padding([.bottom,.top],0)

                    // Create Button
                    Button(action: {
                        self.IsVerfiyPhoneNumber = true
                        self.VerfiyPhoneVM.VerifyPhoneNumber()

                    }, label: {
                        Text(self.isLoading ? "Loading......":"Create")
                                .frame(width: 320,height: 16)
                                .font(.title)
                                .bold()
                                .foregroundColor(.white)
                                .padding()
                                .background(.black)
                                .cornerRadius(16)

                    }).sheet(isPresented: self.$IsVerfiyPhoneNumber){
                        VerfiyCodePhoneView()
                    }
                    .disabled((VerfiyPhoneVM.PhoneNumber.isEmpty && VM.password.isEmpty) ? true:false)
                    .opacity((VerfiyPhoneVM.PhoneNumber.isEmpty && VM.password.isEmpty) ? 0.6:1.0)
                    .padding(.bottom)
                }
            }
        }.padding()
        .navigationBarHidden(true)
    }
}

#Preview {
    CreateBusinessView(email: "rami.alaidy@alaidy.com", VM: LoginEmailViewModel())
        .environmentObject(LoginEmailViewModel())
        .environmentObject(VerifyPhoneViewModel())
}

struct CreateTextFeildCell: View {

    @Binding var text: String
    @Binding var textValue: String

    var IsEmptyData : Bool = false

    var body: some View {
        VStack(alignment: .leading,spacing: 12){

            Text(text)
                .font(.headline)
                .bold()
                .multilineTextAlignment(.leading)

            TextField("Enter your \(text)", text:  self.$textValue)
                .textFieldStyle(.roundedBorder)
                .overlay {
                    Rectangle()
                        .stroke(lineWidth: 1.0)
                        .foregroundColor(.black.opacity(0.7))
                        .cornerRadius(2, corners: .allCorners)
                }
                .shadow(radius: 3)
        }
        .onReceive(self.textValue.publisher, perform: { Textd in
//            self.IsEmptyData  = textValue.isEmpty ? true : false
        })
        .padding(.bottom,8)
    }
}
