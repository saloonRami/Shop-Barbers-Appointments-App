//
//  VerfiyCodePhoneView.swift
//  BarberAppointmentsApp
//
//  Created by Rami Alaidy on 06/12/2023.
//

import SwiftUI
import SwiftRUI

@available(iOS 16.0, *)
struct VerfiyCodePhoneView: View {

    @EnvironmentObject var VerfiyPhoneVM : VerifyPhoneViewModel
    @State var IsVerfiyCode: Bool = false
//    @State var IfUpdatePassword : Bool
    var body: some View {

        NavigationStack {

            Text("OTP code is sent to your mobile number.")
                .foregroundColor(.gray)
                .padding(.vertical, 38)

            OTPTextFieldView(numberOfFields: 6)

            Spacer()

            Button("Send") {

                self.IsVerfiyCode.toggle()

                let reduse = self.VerfiyPhoneVM.OTPVerfiyCode.reduce("") { partialResult, data in
                    partialResult + data
                }
                print(self.VerfiyPhoneVM.OTPVerfiyCode,reduse)
                self.VerfiyPhoneVM.SigninWithVerificationCode(reduse)

                self.VerfiyPhoneVM.GetUserProfile()
                self.VerfiyPhoneVM.GetUserProviderSpecificProfileInformation()

            }
            .buttonStyle(
                RUIRoundedCornerIconButtonStyle(
                    leadingIcon: {
                        Image(systemName: "paperplane")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.white)
                            .frame(width: 22, height: 22)
                            .padding(.trailing, 4)
                    }
                )
            )
            .fullScreenCover(isPresented: self.$IsVerfiyCode, content: {
               CreateProfileView()
            })
            .padding(.horizontal)


            Text("Didn't recieve code? **Request again**")
                .padding(.vertical)
                .navigationTitle("Verify Phone")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

@available(iOS 16.0, *)
struct VerfiyCodePhoneView_Previews: PreviewProvider {
    static var previews: some View {
        VerfiyCodePhoneView()
            .environmentObject(VerifyPhoneViewModel())
    }
}
