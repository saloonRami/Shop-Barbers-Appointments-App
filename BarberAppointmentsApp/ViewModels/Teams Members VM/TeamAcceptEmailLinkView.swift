//
//  TeamAcceptEmailLinkView.swift
//  BarberAppointmentsApp
//
//  Created by Rami Alaidy on 25/12/2023.
//

import SwiftUI

struct TeamAcceptEmailLinkView: View {

    var email : String

    var body: some View {

        Text("Team Accept Email Link View Controller \(email)")
            .font(.largeTitle)
            .bold()
    }
}

#Preview {
    TeamAcceptEmailLinkView(email: "Rami@gmail.com")
}
