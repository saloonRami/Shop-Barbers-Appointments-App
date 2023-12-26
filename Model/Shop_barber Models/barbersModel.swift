//
//  barbersModel.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 22/09/2023.
//
import Foundation
import Combine

// MARK: - Barber
struct Barber: Codable {
    let autoID: String?
       let isActive: Bool?
       let isWorking: Bool?
       let locationShop: LocationShop?
       let parentID: String?
       let shopName: String?
       let shopID: String?
       let creationDate: String?
       let email: String?
       let fcm: String?
       let isAvailable: Bool?
       let isEmailVerified: Bool?
       let isOwner: Bool?
       let isPersistenceEnabledID: Bool?
       let lastSignInDate: String?
       let name: String?
       let password: String?
       let permission: String?
       let providerID: String?
       let refreshToken: String?
       let tenantID: Int?
       let urlAutoID: String?
       let userIDBarber: String?
       let userIDOwner: String?
       let userName: String?
       let uuid: String?

       enum CodingKeys: String, CodingKey {
           case autoID = "AutoId"
           case isActive = "IsActive"
           case isWorking = "IsWorking"
           case locationShop = "Location_shop"
           case parentID = "Parent_Id"
           case shopName = "ShopName"
           case shopID = "Shop_id"
           case creationDate = "creationDate"
           case email = "email"
           case fcm = "fcm"
           case isAvailable = "isAvailable"
           case isEmailVerified = "isEmailVerified"
           case isOwner = "isOwner"
           case isPersistenceEnabledID = "isPersistenceEnabled_Id"
           case lastSignInDate = "lastSignInDate"
           case name = "name"
           case password = "password"
           case permission = "permission"
           case providerID = "providerID"
           case refreshToken = "refreshToken"
           case tenantID = "tenantID"
           case urlAutoID = "url_AutoId"
           case userIDBarber = "userID_barber"
           case userIDOwner = "userID_owner"
           case userName = "user_name"
           case uuid = "uuid"
       }
}

// MARK: - SocialMedia
struct SocialMedia: Codable {
    let image: String?
    let linkName: String?
    let urlSocail: String?

    enum CodingKeys: String, CodingKey {
        case image = "Image"
        case linkName = "link_name"
        case urlSocail = "url_socail"
    }
}
struct all_Barbers: Codable{

    let ChildByAutoId : [Barber]?

    enum CodingKeys: String,CodingKey {
        case ChildByAutoId = "all_Barbers"
    }
}

// MARK: - UserBarberValue
struct UserBarberValue: Codable {
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
    var appointment: Appointment?
    var  manage_services: ManageServicesModel?

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
        case appointment = "Appointment"
        case manage_services = "manage_services"
    }
}

// MARK: UserBarberValue convenience initializers and mutators

extension UserBarberValue {
//    init(data: Data) throws {
//        self = try newJSONDecoder().decode(UserBarberValue.self, from: data)
//    }

//    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
//        guard let data = json.data(using: encoding) else {
//            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
//        }
//        try self.init(data: data)
//    }

//    init(fromURL url: URL) throws {
//        try self.init(data: try Data(contentsOf: url))
//    }

    func with(
        isActive: Bool?? = nil,
        isWorking: Bool?? = nil,
        shopName: String?? = nil,
        shopID: String?? = nil,
        childByAutoID: String?? = nil,
        email: String?? = nil,
        fcm: String?? = nil,
        isAvailable: Bool?? = nil,
        isOwner: Bool?? = nil,
        name: String?? = nil,
        password: String?? = nil,
        permission: String?? = nil,
        phone: String?? = nil,
        userID: String?? = nil,
        appointment: Appointment?? = nil,
        manage_services: ManageServicesModel?? = nil
    ) -> UserBarberValue {
        return UserBarberValue(
            isActive: isActive ?? self.isActive,
            isWorking: isWorking ?? self.isWorking,
            shopName: shopName ?? self.shopName,
            shopID: shopID ?? self.shopID,
            childByAutoID: childByAutoID ?? self.childByAutoID,
            email: email ?? self.email,
            fcm: fcm ?? self.fcm,
            isAvailable: isAvailable ?? self.isAvailable,
            isOwner: isOwner ?? self.isOwner,
            name: name ?? self.name,
            password: password ?? self.password,
            permission: permission ?? self.permission,
            phone: phone ?? self.phone,
            userID: userID ?? self.userID,
            appointment: appointment ?? self.appointment,
            manage_services: manage_services ??  self.manage_services

        )
    }

//    func jsonData() throws -> Data {
//        return try newJSONEncoder().encode(self)
//    }

//    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
//        return String(data: try self.jsonData(), encoding: encoding)
//    }
}
// MARK: - LocationShop
struct LocationShop: Codable,Hashable {
    var latitude: Double?
    var longitude: Double?

    enum CodingKeys: String, CodingKey {
        case latitude = "latitude"
        case longitude = "longitude"
    }
}
// MARK: - Appointment
struct Appointment: Codable {
    var endWork: String?
    var breakEnd: String?
    var breakStart: String?
    var startWork: String?
    var weekendWork: String?

    enum CodingKeys: String, CodingKey {
        case endWork = "End_work"
        case breakEnd = "break_end"
        case breakStart = "break_start"
        case startWork = "start_work"
        case weekendWork = "weekend_work"
    }
}

// MARK: - ManageServicesModel
struct ManageServicesModel: Codable{

    var TimeDuration_service: String?
    var name_service: String?
    var price_service: String?

    enum CodingKeys: String, CodingKey {
        case TimeDuration_service = "TimeDuration_service"
        case name_service = "name_service"
        case price_service = "price_service"

    }
}

// MARK: Appointment convenience initializers and mutators

//extension Appointment {
//    init(data: Data) throws {
//        self = try newJSONDecoder().decode(Appointment.self, from: data)
//    }
//
//    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
//        guard let data = json.data(using: encoding) else {
//            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
//        }
//        try self.init(data: data)
//    }
//
//    init(fromURL url: URL) throws {
//        try self.init(data: try Data(contentsOf: url))
//    }
//
//    func with(
//        endWork: String?? = nil,
//        breakEnd: String?? = nil,
//        breakStart: String?? = nil,
//        startWork: String?? = nil,
//        weekendWork: String?? = nil
//    ) -> Appointment {
//        return Appointment(
//            endWork: endWork ?? self.endWork,
//            breakEnd: breakEnd ?? self.breakEnd,
//            breakStart: breakStart ?? self.breakStart,
//            startWork: startWork ?? self.startWork,
//            weekendWork: weekendWork ?? self.weekendWork
//        )
//    }
//
//    func jsonData() throws -> Data {
//        return try newJSONEncoder().encode(self)
//    }
//
//    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
//        return String(data: try self.jsonData(), encoding: encoding)
//    }
//}
