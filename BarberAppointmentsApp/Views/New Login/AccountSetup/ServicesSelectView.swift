//
//  ServicesSelectView.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 03/11/2023.
//

import SwiftUI

struct ServicesSelectView: View {

    @State var ServicesProvider: CategoryServicesProvidesList = (.init(stringValue: "") ?? .Makeup)
    // 2
    @State private var multiSelection : Set<UUID> = []
    @State var selected: Set<String> = []

    var body: some View {

//        NavigationView {

        VStack(alignment: .leading,spacing: 12) {

            VStack{
                    Text("What services do you offer?")
                        .font(.title2)
                        .bold()
                        .padding(.trailing)

                    Text("Choose your primary and up to related service types.")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.gray.opacity(0.9))
                        .padding(.leading)

            }
                VStack {
                    // 3
                    List(ServicesProvider.CategoryServicesNameAll, selection: $selected) {

                        if !selected.contains($0.name){
                            serviceRow(symbolName: $0.name, uuid: $0.id, selected: $selected)
                                .disabled(selected.count < 4  ? false: true)
                                .opacity(selected.count < 4  ? 1.0:0.3)

                        }else{
                            serviceRow(symbolName: $0.name, uuid: $0.id, selected: $selected)
                        }
                    }.foregroundColor(.black)
//                    Text("\(selected.count) selections")
                }
//                Spacer()
        }
    }
}

#Preview {
    ServicesSelectView(ServicesProvider: CategoryServicesProvidesList.Injectable)
}


import SwiftUI

struct serviceRow2: View {

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
