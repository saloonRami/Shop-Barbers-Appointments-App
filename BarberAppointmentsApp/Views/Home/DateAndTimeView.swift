//
//  DateAndTimeView.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 03/09/2023.
//

import SwiftUI


struct DateAndTimeView: View {

    @Binding var value: Date
    var name: String
    @Binding var isTime : Bool
    var isDisable : Bool?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(name.uppercased())
                .font(.system(.caption2, design: .rounded))
                .bold()
//                .frame(width: 75)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .foregroundColor(.primary)
                .padding(.horizontal)

            if isDisable == true{
                DatePicker("", selection: $value,in: Date.now...Date.today,displayedComponents: isTime ? .hourAndMinute: .date)
                    .accentColor(.primary)
                    .border(Color("Border"), width: 1.0)
                    .menuStyle(.borderlessButton)
                    .labelsHidden()
                    .padding(10)
                    .datePickerStyle(.automatic)
                //                .disabled(self.isDisable == true ? true: false)
            }else{
                DatePicker("", selection: $value,displayedComponents: isTime ? .hourAndMinute: .date)
                    .accentColor(.primary)
                    .border(Color("Border"), width: 1.0)
                    .menuStyle(.borderlessButton)
                    .labelsHidden()
                    .padding(10)
                    .datePickerStyle(.automatic)
            }
        }
    }
}


struct DateAndTimeView_Previews: PreviewProvider {
    static var previews: some View {
        DateAndTimeView(value: .constant(Date.today), name: "Date", isTime: .constant(false), isDisable: false)
            .environmentObject(AppointmentVM(numberOfServices: 7))
    }
}
