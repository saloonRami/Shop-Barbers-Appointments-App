//
//  DatabaseModel.swift
//  SaloonSwiftUI
//
//  Created by Rami Alaidy on 05/09/2023.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let toy = try? JSONDecoder().decode(Toy.self, from: jsonData)

//import Foundation
//
//// MARK: - DatabaseModel
//struct DatabaseModel: Hashable,Codable {
//    var customer: Customer
//    var hairdresser: Hairdresser
//    var reservedOrders: ReservedOrders
//    var shopBarber: ShopBarberClass
//}
//
//// MARK: - Customer
//struct Customer:  Hashable,Codable,Identifiable {
//var id: UUID
//    var users: Users
//}
//
//// MARK: - Users
//struct Users:  Hashable,Codable    {
//
//    var bbbbbb: Bbbbbb
//    var bbbyyYahooCOM: COM
//    var ramialaidyRrGmailCOM: COM
//    var shanks: Bbbbbb
//}
//
//// MARK: - Bbbbbb
//struct Bbbbbb:  Hashable,Codable    {
//
//    var shopName: String
//    var email: String
//    var name: String
//    var password: String
//    var permission: String
//    var phone: String
//    var status: String
//    var fcm: String?
//}
//
//// MARK: - COM
//struct COM:  Hashable,Codable    {
//
//    var fcm: String
//}
//
//// MARK: - Hairdresser
//struct Hairdresser:  Hashable,Codable    {
//
//    var shopBarber: ShopBarber
//}
//
//// MARK: - ShopBarber
//struct ShopBarber:  Hashable,Codable,Identifiable  {
//    var id: Int
//    var ramialaidyRaGmailCOM: Bbbbbb
//}
//
//// MARK: - ReservedOrders
//struct ReservedOrders:  Hashable,Codable    {
//
//    var shopName: ShopName
//}
//
//// MARK: - ShopName
//struct ShopName:  Hashable,Codable    {
//
//    var appointments: Appointments
//}
//
//// MARK: - Appointments
//struct Appointments:  Hashable,Codable    {
//
//    var phoneCustomer: String
//    var conditionAppintements: String
//    var nameCustomer: String
//    var reservationDate: ReservationDate
//    var typeAppintements: String
//}
//
//// MARK: - ReservationDate
//struct ReservationDate:  Hashable,Codable    {
//
//    var dayReservation: String
//    var timeReservation: String
//}
//
//// MARK: - ShopBarberClass
//struct ShopBarberClass:  Hashable,Codable    {
//
//    var omer: Mustafa
//    var mustafa: Mustafa
//}
//
//// MARK: - Mustafa
//struct Mustafa:  Hashable,Codable    {
//
//    var barber: Barber
//    var shopInfo: ShopInfo
//    var appointments: Appointments
//    var products: Products
//}
//
//// MARK: - Barber
//struct Barber:  Hashable,Codable    {
//
//    var orderNum: Int
//    var shopName: String
//    var email: String
//    var fcm: String
//    var imageProfile: String
//    var isAVailable: Bool
//    var isOwner: Bool
//    var name: String
//}
//
//// MARK: - Products
//struct Products:  Hashable,Codable    {
//
//    var cat: String
//    var description: String
//    var imageProduct: String
//    var isAvailable: String
//    var name: String
//    var price: Int
//    var quantity: Int
//}
//
//// MARK: - ShopInfo
//struct ShopInfo:  Hashable,Codable    {
//
//    var locationString: String
//    var category: String
//    var city: String
//    var coordinates: Coordinates
//    var description: String
//    var email: String
//    var fcm: String
//    var genderSalon: String
//    var imageName: String
//    var isAvailable: String
//    var isFavorite: Bool
//    var isFeatured: Bool
//    var name: String
//    var phone: String
//    var region: String
//    var services: [String]
//    var shopName: String
//    var status: String
//}
//
//// MARK: - Coordinates
//struct Coordinates:  Hashable,Codable    {
//
//    var latitude: Double
//    var longitude: Double
//}
