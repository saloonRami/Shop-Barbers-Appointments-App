//
//  ProductsAvailableModel.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 05/09/2023.
//

import Foundation

enum ProductsAvailableModel:Int,CaseIterable{
    case Shampoo = 0
    case Balm = 1
    case hairDye = 2
    case Wig = 3
    case Other = 4

    init(type: Int) {
        switch type{
        case 0: self = .Shampoo
        case 1: self = .Balm
        case 2: self = .hairDye
        case 3: self = .Wig
        case 4: self = .Other
        default:self = .Shampoo

        }
    }
    var text: String {
        switch self {
        case .Shampoo: return "Shampoo"
        case .Balm: return "Balm"
        case .hairDye: return "hair Dye"
        case.Wig: return "Wig"
        case.Other: return "Others"
        }
    }
}
