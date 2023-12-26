//
//  ShopbarberModel.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 03/09/2023.
//

import Foundation

final class ShopbarberModelData: ObservableObject {
    @Published var Salons: [ProductsModel] = load("ProductsJson.json")

    @Published var profile = Profile.default

    var Available: [ProductsModel] {
        Salons.filter { $0.isAvailable }
    }

    var shopBarber: [String: [ProductsModel]] {
        Dictionary(
            grouping: Salons,
            by: { $0.shopBarber }
        )
    }
}

//func load<T: Decodable>(_ filename: String) -> T {
//    let data: Data
//
//    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
//        else {
//            fatalError("Couldn't find \(filename) in main bundle.")
//    }
//
//    do {
//        data = try Data(contentsOf: file)
//    } catch {
//        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
//    }
//
//    do {
//        let decoder = JSONDecoder()
//        return try decoder.decode(T.self, from: data)
//    } catch {
//        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
//    }
//}
