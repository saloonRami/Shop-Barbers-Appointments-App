//
//  Shop_infoModel.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 21/09/2023.
//

import Foundation

// MARK: - ShopInfo
struct Shop_info: Codable {

//    var locationShop: LocationShop?
    var shopName: String?
    var childByAutoID: String?
    var creationDate: String?
    var email: String?
    var lastSignInDate: String?
    var name: String?
    var password: String?
    var permission: String?
    var phone: String?
    var providerID: String?
    var refreshToken: String?
    var status: String?
    var tenantID: Int?
    var userID: String?
    var userName: String?
    var uuid: String?
    var fcm: String?

    enum CodingKeys: String, CodingKey {
//        case locationShop = "Location_shop"
        case shopName = "ShopName"
        case childByAutoID = "childByAutoId"
        case creationDate = "creationDate"
        case email = "email"
        case lastSignInDate = "lastSignInDate"
        case name = "name"
        case password = "password"
        case permission = "permission"
        case phone = "phone"
        case providerID = "providerID"
        case refreshToken = "refreshToken"
        case status = "status"
        case tenantID = "tenantID"
        case userID = "userID"
        case userName = "user_name"
        case uuid = "uuid"
        case fcm = "fcm"
    }
}

//// MARK: - LocationShop
//struct LocationShop: Codable {
//    var latitude: Double?
//    var longitude: Double?
//
//    enum CodingKeys: String, CodingKey {
//        case latitude = "latitude"
//        case longitude = "longitude"
//    }
//}


