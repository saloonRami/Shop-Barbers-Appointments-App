//
//  OTPTextFieldView.swift
//  BarberAppointmentsApp
//
//  Created by Rami Alaidy on 06/12/2023.
//

import Foundation
import SwiftUI

struct OTPTextFieldView: View {
    let numberOfFields : Int
    @State var enterValue : [String]
    @FocusState private var feildFocus: Int?
    @State var oldValue  = ""

    @EnvironmentObject var VerfiyPhoneVM : VerifyPhoneViewModel
    @FocusState var isFocusedTextField : Bool
    init(numberOfFields:Int){
        self.numberOfFields = numberOfFields
        self.enterValue = Array(repeating: "", count: self.numberOfFields)
    }
    var body: some View {

        HStack {
            ForEach(0..<numberOfFields,id: \.self) { index in

                TextField("", text: self.$enterValue[index],onEditingChanged: { editing in
                    if editing {
                    oldValue = enterValue[index]
                    }
                })
                    .keyboardType(.numberPad)
                    .frame(width: 48,height: 48)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(5)
                    .multilineTextAlignment(.center)
                    .focused($feildFocus,equals: index)
                    .onChange(of: enterValue[index]) { newValue in

                        if enterValue[index].count > 1{
                            let currentValue = Array (enterValue [index])

                            if currentValue[0] == Character (oldValue) {
                                enterValue[index] = String(enterValue[index].suffix(1))
                            }else{
                                enterValue[index] = String(enterValue[index].prefix(1))
                            }
                        }
                        if !newValue.isEmpty{
                            if index == self.numberOfFields - 1{
                                feildFocus = nil
                            }else{
                                feildFocus = (feildFocus ?? 0) + 1
                            }
                        }else{
                            feildFocus = (feildFocus ?? 0) - 1
                        }
                        self.VerfiyPhoneVM.OTPVerfiyCode = self.enterValue
                    }
            }
        }
    }
}

struct OTPTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        OTPTextFieldView(numberOfFields: 6)
    }
}
