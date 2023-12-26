//
//  SettingsStore.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 03/09/2023.
//


import Foundation
import SwiftUI

enum SettingsStore {
  static let cardSize = CGSize(width: 1500, height: 1500)
  static func thumbnailSize(size: CGSize) -> CGSize {
    let threshold: CGFloat = 600
    var scale: CGFloat = 0.12
    if size.width > threshold && size.height > threshold {
      scale = 0.4
    }
//    var rememberUser: Bool = false
    return CGSize(
      width: SettingsStore.cardSize.width * scale,
      height: SettingsStore.cardSize.height * scale)
  }

  static let defaultElementSize =
    CGSize(width: 800, height: 800)
  static let borderColor: Color = .blue
  static let borderWidth: CGFloat = 5
  static var rememberUser: Bool = false
}
