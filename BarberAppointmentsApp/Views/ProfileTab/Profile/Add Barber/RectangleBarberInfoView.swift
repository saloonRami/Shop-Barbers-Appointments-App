//
//  RectangleBarberInfoView.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 27/09/2023.
//

import SwiftUI

struct RectangleBarberInfoView: View {
    var height : Double
    @EnvironmentObject var AppointmentViewModel : AppointmentVM

    @AppStorage("IsMonitorAttendance)") var IsMonitorAttendance: Bool = false
    @AppStorage("IsWeekendDayBarber") var IsWeekend: Bool = false

    @State private var SelectedDateOff  = dayOffNum.Friday
    @State private var workNature  = workNatureEnum.employee


    var body: some View {
        ScrollView {

            VStack{
                Rectangle()
                    .fill()
                    .frame(height: height )
                    .cornerRadius(56, corners: [.topRight,.topLeft])

                    .overlay {
                        List{
//                            Text("Time Management")
//                                .font(.headline)
//                                .bold()
//                                .foregroundColor(.black)
//                                .frame(width: 400)
//                                .multilineTextAlignment(.center)
                            Section(header: Text("A specific time to receive appointments each day")) {
                                HStack{
                                    DateAndTimeView(value: self.$AppointmentViewModel.valueStartDate, name: "from Today", isTime: .constant(false), isDisable: true)
                                        .environmentObject(AppointmentVM(numberOfServices: 7))
                                    DateAndTimeView(value: self.$AppointmentViewModel.StartvalueTime, name: "Start Time", isTime: .constant(true),isDisable: false)
                                        .environmentObject(AppointmentVM(numberOfServices: 7))
                                    DateAndTimeView(value: self.self.$AppointmentViewModel.EndvalueTimeDuture, name: "End Time", isTime: .constant(true),isDisable: false)
                                        .environmentObject(AppointmentVM(numberOfServices: 7))
                                }
                            }
                            Section(header: Text("Determine a weekly day")) {
                                Toggle("Do you want a weekend vacation?", isOn: $IsWeekend)

                                Picker(selection: self.$SelectedDateOff,label:

                                        Text("Display order")

                                    .foregroundColor(.black)
                                ) {
                                    ForEach(dayOffNum.allCases,id: \.self) { productsType in
                                        Text(productsType.text)
                                    }
                                }.pickerStyle(.menu )
                            }
                            Section(header: Text("Determine Break And Lunch Time")) {

                                HStack{
                                    Text("Choose Your Break Time")
                                        .font(.headline)
                                        .bold()
                                        .padding(.trailing,2)
                                    DateAndTimeView(value:self.$AppointmentViewModel.valueTime, name: "Start Time", isTime: .constant(true),isDisable: false)
                                        .environmentObject(AppointmentVM(numberOfServices: 7))
                                        .padding(.vertical)
                                    DateAndTimeView(value: self.$AppointmentViewModel.valueTimeDuture, name: "End Time", isTime: .constant(true),isDisable: false)
                                        .environmentObject(AppointmentVM(numberOfServices: 7))
                                        .padding(.vertical)
                                }
                                Text(" \(self.AppointmentViewModel.AddBreakTime.description.dropFirst(26).dropLast(2).description)")
                                    .font(.subheadline)
                            }
                            Section(header: Text(self.AppointmentViewModel.dayOff.text )) {
                                Picker(selection: self.$workNature,label:

                                        Text("Work Nature")

                                    .foregroundColor(.black)
                                ) {
                                    ForEach(workNatureEnum.allCases,id: \.self) { workNature in
//                                        indexWork = self.$work
                                        Text(workNature.text)
                                    }

                                }.pickerStyle(.automatic )

                                Toggle("Do you want to monitor your attendance?", isOn: $IsMonitorAttendance)
                                
                            }
                        }
                        .cornerRadius(56, corners: [.topRight,.topLeft])
                    }
            }
        }
    }
}
struct RectangleBarberInfoView_Previews: PreviewProvider {
    static var previews: some View {
        RectangleBarberInfoView(height: 1000)
            .environmentObject(AppointmentVM(numberOfServices: 7))
    }
}
