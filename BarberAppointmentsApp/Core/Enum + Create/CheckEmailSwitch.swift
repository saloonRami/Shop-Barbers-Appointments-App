//
//  CheckEmailSwitch.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 02/11/2023.
//


import Foundation
import SwiftUI

protocol SwitchProtocol{
    func GetSwitch(email:String) -> AnyView
}

enum SwitchCheckEmail:String,CaseIterable,CodingKey,SwitchProtocol{

    case password = "password"
    case NotExist = "nil"

    func GetSwitch(email :String) -> AnyView {
        switch self{
        case .password:
            return AnyView(AddPasswordView(email:email,VM:LoginEmailViewModel()))
        case .NotExist:
            return AnyView(CreateBusinessView(email: email,VM:LoginEmailViewModel()))
        }
    }
}
