//
//  Filev.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 24/09/2023.
//

import Foundation
import SwiftUI


extension Color {
  init(rgba: Int) {
    self.init(
      .sRGB,
      red: Double((rgba & 0xFF000000) >> 24) / 255,
      green: Double((rgba & 0x00FF0000) >> 16) / 255,
      blue: Double((rgba & 0x0000FF00) >> 8) / 255,
      opacity: Double((rgba & 0x000000FF)) / 255
    )
  }

  var asRgba: Int {
    guard let components = cgColor?.components else { return 0 }
    let (red, green, blue, alpha) = (components[0], components[1], components[2], components[3])
    return
      (Int(alpha * 255) << 0) +
      (Int(blue * 255) << 8) +
      (Int(green * 255) << 16) +
      (Int(red * 255) << 24)
  }
}
