//
//  RegisterViewModel.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 03/09/2023.
//

import Foundation
import SwiftUI
import Combine
import FirebaseAuth

final class RegisterViewModel:ObservableObject{

    @Published var email: String = ""
    @Published var password: String = ""

    init() {
        self.email = email
        createUser()
    }
    func createUser(){
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in

        }
    }
}
