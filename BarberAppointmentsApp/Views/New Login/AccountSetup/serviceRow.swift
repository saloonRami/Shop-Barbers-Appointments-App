//
//  serviceRow.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 04/11/2023.
//

import SwiftUI

struct serviceRow: View {

  let symbolName: String
  let uuid : UUID

  @Binding var selected: Set<String>

  var body: some View {

    Button(action: {
      if !selected.insert(symbolName).inserted {
        selected.remove(symbolName)
      }
    }, label: {
      HStack {
          HStack(alignment: .center,spacing: 12) {
              if selected.contains(symbolName) {
                  Image(systemName: "checkmark")
                      .fontWeight(.bold)
                      .padding(.trailing)
              }
          }
        .frame(width: 8)
        Text(symbolName)
          .fontWeight(.bold)
      }
    })
  }
}

#Preview {
    serviceRow(symbolName: "Rami", uuid: UUID(), selected: .constant(Set(arrayLiteral: "dd")))
}
