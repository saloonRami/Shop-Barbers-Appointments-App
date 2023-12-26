//
//  AddProductsViewModel.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 03/09/2023.
//

import Foundation
import Combine
import SwiftUI
final class AddProductsViewModel:ObservableObject {

    // Input
    @Published var nameProducts: String = ""
    @Published var nameBrand: String = ""
    @Published var priceProducts: String = "0"
    @Published var info: String = ""
    @Published var date: Date = .today
    @Published var quantaity: String = "0"
    @Published var imageProducts: Image  = .init(systemName: "person")
    // Output
    @Published var IsnameProducts: Bool = false
    @Published var IspriceProducts: Bool = false
    @Published var Isinfo: Bool = false
    @Published var ISquantaity: Bool = false
    @Published var ISimageProducts: Bool = false
    @Published var isFormInputValid = false

    private var cancellableSet: Set<AnyCancellable> = []
    
    init() {
        self.nameProducts = nameProducts
        self.priceProducts = priceProducts
        self.info = info
        self.quantaity = quantaity
        self.imageProducts = imageProducts
        self.IsnameProducts = IsnameProducts
        self.IspriceProducts = IspriceProducts
        self.Isinfo = Isinfo
        self.ISquantaity = ISquantaity
        self.ISimageProducts = ISimageProducts
        self.date = date


        $nameProducts
            .receive(on: RunLoop.main)
            .map { name in
               return name.count >= 4
            }
            .assign(to: \.IsnameProducts, on: self)
            .store(in: &cancellableSet)

        $priceProducts
            .receive(on: RunLoop.main)
            .map { price in
                return !price.isEmpty && price != "0"
            }
            .assign(to: \.IspriceProducts, on: self)
            .store(in: &cancellableSet)

        $quantaity
            .receive(on: RunLoop.main)
            .map { name in
                return !name.isEmpty && name != "0"
            }
            .assign(to: \.ISquantaity, on: self)
            .store(in: &cancellableSet)

        Publishers.CombineLatest3($IsnameProducts, $IspriceProducts, $ISquantaity)
            .receive(on: RunLoop.main)
            .map { (isNameValid, isAmountValid, isMemoValid) in
                return isNameValid && isAmountValid && isMemoValid
            }
            .assign(to: \.isFormInputValid, on: self)
            .store(in: &cancellableSet)
    }

}
