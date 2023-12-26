//
//  DatabaseModelValue.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 22/09/2023.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseDatabase

var ref = Database.database().reference()

let user = Auth.auth().currentUser?.description

struct DatabaseModelValue:Codable {

    let BarberArray: [Barber]?
//    let Barber: Barber?
    let shopInfo: Shop_info?
//    let appointments: Appointments?
//    let products: Products?
    
    enum CodingKeys: String, CodingKey {
//        case Barber
        case  BarberArray = "Barber"
        case shopInfo = "Shop_info"
//        case appointments = "appointments"
//        case products = "products"
    }
}
typealias Shop_barber_InfoModel = [String: DatabaseModelValue]

