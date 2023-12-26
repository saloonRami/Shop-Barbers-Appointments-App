//
//  SettingStore.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 05/09/2023.
//

import SwiftUI
import Combine
final class SettingStore: ObservableObject {

    init() {
        UserDefaults.standard.register(defaults: [
            "view.preferences.showCheckInOnly" : false,
            "view.preferences.displayOrder" : 0,
            "view.preferences.maxPriceLevel" : 5
        ])
    }
   @Published var showCheckInOnly: Bool = UserDefaults.standard.bool(forKey: "view.preferenc es.showCheckInOnly") {
        didSet {
            UserDefaults.standard.set(showCheckInOnly, forKey: "view.preferences.showCheckInOnly")
        }
    }
    @Published  var displayOrder: ProductsAvailableModel = ProductsAvailableModel(type: UserDefaults.standard.integer(forKey: "view.preferences.displayOrder")) {
        didSet {
            UserDefaults.standard.set(displayOrder.rawValue, forKey: "view.preferences.displayOrder")
        }
    }
    @Published  var maxPriceLevel: Int = UserDefaults.standard.integer(forKey: "view.preferenc es.maxPriceLevel") {
        didSet {
            UserDefaults.standard.set(maxPriceLevel, forKey: "view.preferences.maxPriceLevel")
        }
    }

}
