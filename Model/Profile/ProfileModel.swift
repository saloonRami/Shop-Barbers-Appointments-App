//
//  ProfileModel.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 27/09/2023.
//

import Foundation
import Firebase

struct ProfileModel{

    var uid : String
    var photoURL : URL
    var display_name : String
    var email : String
    var phoneNumber : String
    var providerID: String
    var refreshToken: String?
    var tenantID: String?
    var providerData: [UserInfo]
    var metadata: UserMetadata
    var multiFactor: MultiFactor
    var dateOfbrith : String
    var gender : String
    var shopName : String
    var Locations : String
    
}

enum ProfileNum:String, CaseIterable{
    case UserID
    case photoURL
    case Name
    case Email
    case password
    case MobileNum = "Mobile Number"
    case dateOfbrith = "Date Of Birth"
    case Gender
    case shopNamw
    case Locations
    static var allCases: [ProfileNum] = [.UserID,photoURL,.Name,.Email,.password,.MobileNum,.dateOfbrith,.Gender,.shopNamw,.Locations]

}

