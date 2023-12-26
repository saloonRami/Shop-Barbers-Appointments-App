//
//  TextFieldView.swift
//  BarberAppointmentsApp
//
//  Created by Rami Alaidy on 06/12/2023.
//

import SwiftUI

struct TextFieldView: View {

    var fieldName = ""
    @Binding var fieldValue: String

    var isSecure = false
    var keyboardEn : keyboardEnm
    @State var isCenterText: Bool = false
    var body: some View {
        VStack{

            if isSecure {
                Text(isCenterText ? "": fieldName  )
                    .font(.system(.subheadline, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(.black)

//                    .padding()
                SecureField(fieldName, text: $fieldValue)
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .foregroundColor(.darkGreen)
                    .foregroundColor(Color(red: 251/255, green: 128/255, blue: 128/255))
                    .padding(.horizontal)

            } else {
                Text(isCenterText ? "": fieldName  )
                    .font(.system(.subheadline, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .multilineTextAlignment(isCenterText ? .leading:.center)
//                    .padding()
                TextField(fieldName, text: $fieldValue )
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .foregroundColor(Color(red: 251/255, green: 128/255, blue: 128/255))
                    .multilineTextAlignment(isCenterText ? .leading:.center)
                    .padding()
                    .border(Color("Border"), width: 1.0)
                    .keyboardType(getKeyboard())


            }
            Divider()
                .frame(height: 1)
                .foregroundColor(Color(red: 251/255, green: 128/255, blue: 128/255))
                .background(Color(red: 240/255, green: 240/255, blue: 240/255))
                .padding(.horizontal)
        }
    }
    public  func getKeyboard() -> UIKeyboardType{
        switch keyboardEn {

        case .email:
            return UIKeyboardType.emailAddress
        case .phoneNum:
            return   UIKeyboardType.phonePad
        case .password:
            return  UIKeyboardType.numbersAndPunctuation
        case .userName:
            return   UIKeyboardType.namePhonePad
        case .Location:
            return  UIKeyboardType.webSearch
        case .defaults:
            return   UIKeyboardType.default
        case .price:
            return   UIKeyboardType.decimalPad
        case .quantaity:
            return   UIKeyboardType.numberPad
        case .url:
            return   UIKeyboardType.URL
        case .Capable:
            return   UIKeyboardType.asciiCapable
        case .twitter:
            return   UIKeyboardType.twitter
        case .alphabet:
            return   UIKeyboardType.alphabet
        }
    }
}

struct TextFieldView_Previews: PreviewProvider {

    static var previews: some View {

        TextFieldView(fieldValue: .constant("user"), keyboardEn: .email)
    }
}

public enum keyboardEnm {

case email
case phoneNum
case password
case userName
case Location
case defaults
case price
case quantaity
case url
case Capable
case twitter
case alphabet


    public  func getKeyboard() -> UIKeyboardType{
        switch self {

        case .email:
           return UIKeyboardType.emailAddress
        case .phoneNum:
            return   UIKeyboardType.phonePad
        case .password:
            return  UIKeyboardType.numbersAndPunctuation
        case .userName:
            return   UIKeyboardType.namePhonePad
        case .Location:
            return  UIKeyboardType.webSearch
        case .defaults:
            return UIKeyboardType.default
        case .price:
            return UIKeyboardType.decimalPad
        case .quantaity:
            return UIKeyboardType.numberPad
        case .url:
            return UIKeyboardType.URL
        case .Capable:
            return UIKeyboardType.asciiCapable
        case .twitter:
            return UIKeyboardType.twitter
        case .alphabet:
            return UIKeyboardType.alphabet
        }
    }
}

extension Color {


public init(red: Int, green: Int, blue: Int, opacity: Double = 1.0) { let redValue = Double(red) / 255.0
let greenValue = Double(green) / 255.0
let blueValue = Double(blue) / 255.0
self.init(red: redValue, green: greenValue, blue: blueValue, opacity: opacity) }

public static let lightRed = Color(red: 231, green: 76, blue: 60)
          public static let darkRed = Color(red: 192, green: 57, blue: 43)
          public static let lightGreen = Color(red: 46, green: 204, blue: 113)
          public static let darkGreen = Color(red: 39, green: 174, blue: 96)
          public static let lightPurple = Color(red: 155, green: 89, blue: 182)
          public static let darkPurple = Color(red: 142, green: 68, blue: 173)
          public static let lightBlue = Color(red: 52, green: 152, blue: 219)
          public static let darkBlue = Color(red: 41, green: 128, blue: 185)
          public static let lightYellow = Color(red: 241, green: 196, blue: 15)
          public static let darkYellow = Color(red: 243, green: 156, blue: 18)
          public static let lightOrange = Color(red: 230, green: 126, blue: 34)
          public static let darkOrange = Color(red: 211, green: 84, blue: 0)
          public static let purpleBg = Color(red: 69, green: 51, blue: 201)
}

