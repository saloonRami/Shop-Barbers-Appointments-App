//
//  StepperView.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 03/09/2023.
//

import SwiftUI

struct StepperView: View {
    @Binding var numberOfDays : Int

    var body: some View {
        VStack(alignment: .leading) {
            Stepper(
                "Number of Reservation Days: \(numberOfDays)",
                value: $numberOfDays,
                in: 7 ... 31
            )
            Text("Any change will affect the next game")
                .font(.caption2)
                .foregroundColor(.secondary)
        }
        .padding()
    }
}


struct StepperView_Previews: PreviewProvider {
    static var previews: some View {
        StepperView(numberOfDays: .constant(6))
    }
}
