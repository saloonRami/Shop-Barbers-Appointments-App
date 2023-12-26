//
//  SwiftUIView.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 03/09/2023.
//

import SwiftUI


struct AppearanceView: View {
    @AppStorage("appearances") var appearance: Appearance = .automatic
    @AppStorage("cardBackgroundColor") var cardBackgroundColorInt: Int = 0xFF0000FF
    @Binding var cardBackgroundColor : Color

    var body: some View {
       
        VStack(alignment: .leading) {
            Picker("", selection: $appearance) {
                ForEach(Appearance.allCases) { appearanceA in
                    Text(appearanceA.name)
                        .tag(appearanceA)
                }
            }
            .pickerStyle(SegmentedPickerStyle())

            ColorPicker(
                "Card Background Color",
                selection: Binding(
                    get: { cardBackgroundColor },
                    set: { newValue in
                        cardBackgroundColorInt = newValue.asRgba
                        cardBackgroundColor = newValue
                    }
                )
            )
        }
    }
}

struct AppearanceView_Previews: PreviewProvider {
    static var previews: some View {
        AppearanceView(cardBackgroundColor: .constant(Color.red))
    }
}
