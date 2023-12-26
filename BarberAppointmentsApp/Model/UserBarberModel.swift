//
//  UserBarberModel.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 02/10/2023.
//

import Foundation

// MARK: - UserBarber

struct UserBarberModel: Codable {
    
    var isActive: Bool?
    var isWorking: Bool?
    var shopName: String?
    var shopID: String?
    var childByAutoID: String?
    var email: String?
    var fcm: String?
    var isAvailable: Bool?
    var isOwner: Bool?
    var name: String?
    var password: String?
    var permission: String?
    var phone: String?
    var userID: String?

    enum CodingKeys: String, CodingKey {
        case isActive = "IsActive"
        case isWorking = "IsWorking"
        case shopName = "ShopName"
        case shopID = "Shop_id"
        case childByAutoID = "childByAutoId"
        case email = "email"
        case fcm = "fcm"
        case isAvailable = "isAvailable"
        case isOwner = "isOwner"
        case name = "name"
        case password = "password"
        case permission = "permission"
        case phone = "phone"
        case userID = "userID"
    }
}
