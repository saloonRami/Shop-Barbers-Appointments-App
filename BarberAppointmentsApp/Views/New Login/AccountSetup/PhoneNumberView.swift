//
//  PhoneNumberView.swift
//  BarberAppointmentsApp
//
//  Created by Rami Alaidy on 06/12/2023.
//

import SwiftUI

struct PhoneNumberView: View {

    @Binding var PhoneNumber : String
    @Binding var Name : String
     var keyboardEn : keyboardEnm


    var body: some View {
        HStack{
            VStack{
                Text("🇯🇴" + " +962")
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
            VStack{

                TextField(Name, text: $PhoneNumber)
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
//        .padding(.horizontal)
    }
}

struct PhoneNumberView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneNumberView(PhoneNumber: .constant("value"), Name: .constant("Rami"), keyboardEn: .phoneNum)
    }
}
