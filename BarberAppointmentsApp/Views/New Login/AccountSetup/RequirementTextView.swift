//
//  Req.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 02/09/2023.
//

import SwiftUI

struct RequirementTextView: View {

    var iconName = "xmark.square"
    var iconColor = Color(red: 251/255, green: 128/255, blue: 128/255)
//    var keyType : UIKeyboardType
    var text = ""
    var textSecandary : String?
    var isStrikeThrough = false
    var textThrough = false

    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(isStrikeThrough ?  iconColor : .red )
            Text((textThrough ? textSecandary:text) ?? "" )
                .font(.system(.body, design: .rounded))
                .foregroundColor(isStrikeThrough ?  iconColor : .red)
                .strikethrough(isStrikeThrough)

            Spacer()
        }
    }
}

struct RequirementTextView_Previews: PreviewProvider {

    static var previews: some View {
//        @AppStorage("appearances") var appearance: Appearance = .automatic
        RequirementTextView()
//            .preferredColorScheme(appearance.getColorScheme())
//          

    }
}
