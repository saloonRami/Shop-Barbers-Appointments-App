//
//  ShopModel.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 03/09/2023.
//

import Foundation
import SwiftUI
import CoreLocation

struct ShopModelJson: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var genderSalon: String
    var city: String
    var phone: String
    var email:String
    var LocationString: String
    var state: String
    var description: String
    var isFavorite: Bool
    var isFeatured: Bool
    var services: [String]
    var category: Category
//    var background : Color = .gray
    enum Category: String, CaseIterable, Codable {
        case lakes = "Beauty salon"
        case rivers = "Rivers"
        case mountains = "Mountains"
    }

    var imageName: String
    var image: Image {
        Image(imageName)
    }
    var featureImage: Image? {
        isFeatured ? Image(imageName) : nil
    }

    private var coordinates: Coordinates
    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude)
    }

    struct Coordinates: Hashable, Codable {
        var latitude: Double
        var longitude: Double
    }

}
