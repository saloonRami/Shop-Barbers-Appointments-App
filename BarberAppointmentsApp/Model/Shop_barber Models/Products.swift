//
//  ProductsModel.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 22/09/2023.
//

import Foundation

// MARK: - Products
struct Products: Codable {
    let cat: String?
    let description: String?
    let id: Int?
    let imageProduct: String?
    let isAvailable: String?
    let name: String?
    let price: Int?
    let quantity: Int?

    enum CodingKeys: String, CodingKey {
        case cat = "cat"
        case description = "description"
        case id = "id"
        case imageProduct = "image_product"
        case isAvailable = "isAvailable"
        case name = "name"
        case price = "price"
        case quantity = "quantity"
    }
}
