//
//  ShopInfo.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 05/10/2023.
//

import Foundation
// MARK: - ShopInfo
struct ShopInfo: Codable {
    var locationShop: LocationShop?
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
    var status: Bool?
    var tenantID: Int?
    var userID: String?
    var userName: String?
    var uuid: String?

    enum CodingKeys: String, CodingKey {
        case locationShop = "Location_shop"
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
    }
}

// MARK: ShopInfo convenience initializers and mutators

extension ShopInfo {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ShopInfo.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        locationShop: LocationShop?? = nil,
        shopName: String?? = nil,
        childByAutoID: String?? = nil,
        creationDate: String?? = nil,
        email: String?? = nil,
        lastSignInDate: String?? = nil,
        name: String?? = nil,
        password: String?? = nil,
        permission: String?? = nil,
        phone: String?? = nil,
        providerID: String?? = nil,
        refreshToken: String?? = nil,
        status: Bool?? = nil,
        tenantID: Int?? = nil,
        userID: String?? = nil,
        userName: String?? = nil,
        uuid: String?? = nil
    ) -> ShopInfo {
        return ShopInfo(
            locationShop: locationShop ?? self.locationShop,
            shopName: shopName ?? self.shopName,
            childByAutoID: childByAutoID ?? self.childByAutoID,
            creationDate: creationDate ?? self.creationDate,
            email: email ?? self.email,
            lastSignInDate: lastSignInDate ?? self.lastSignInDate,
            name: name ?? self.name,
            password: password ?? self.password,
            permission: permission ?? self.permission,
            phone: phone ?? self.phone,
            providerID: providerID ?? self.providerID,
            refreshToken: refreshToken ?? self.refreshToken,
            status: status ?? self.status,
            tenantID: tenantID ?? self.tenantID,
            userID: userID ?? self.userID,
            userName: userName ?? self.userName,
            uuid: uuid ?? self.uuid
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
    // MARK: - Helper functions for creating encoders and decoders

    func newJSONDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
            decoder.dateDecodingStrategy = .iso8601
        }
        return decoder
    }

    func newJSONEncoder() -> JSONEncoder {
        let encoder = JSONEncoder()
        if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
            encoder.dateEncodingStrategy = .iso8601
        }
        return encoder
    }

}
