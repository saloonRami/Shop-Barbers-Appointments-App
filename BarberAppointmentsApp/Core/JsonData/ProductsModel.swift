//
//  ProductsModel.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 03/09/2023.
//

import Foundation
import SwiftUI

// MARK: - Toy
struct ProductsModel:  Hashable,Codable,Identifiable {

    var id: Int
    var name_prouducts: String
    var price: Int
    var info: String
    var rating: Double
    var minSold: String
    var delivary: Int
    var brand: String
    var brandMade: String
    var shopBarber: String
    var isAvailable: Bool
    var quantity: Int
    
    var imageName: String
    var image: Image {
        Image(imageName)
    }
   
}
