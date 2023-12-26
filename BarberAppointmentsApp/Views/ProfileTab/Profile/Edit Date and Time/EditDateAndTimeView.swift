//
//  EditDateAndTimeView.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 16/09/2023.
//

import SwiftUI

struct EditDateAndTimeView: View {

    @State var valueDate: Date = Date.now
    @State var valueTime: Date = Date.today
    @State var valueTimeDuture: Date = Date.tomorrow
    @State var valueTime2: Date = Date.now + ((60 * 60) * 7)

    @AppStorage("IsProducts") var IsProducts: Bool = false
    @AppStorage("IsWeekend") var IsWeekend: Bool = false
    @EnvironmentObject var AppointmentViewModel : AppointmentVM
    @State private var selectedProducts = ProductsAvailableModel.Shampoo
    @State private var SelectedDateOff  = dayOffNum.Friday

    @EnvironmentObject var DateStore: DateAndTimeStore
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @AppStorage("IsReservation") var learningEnabled: Bool = false

    @AppStorage("numberOfDays") var numberOfDaysReservation = 7

    var body: some View {
        NavigationStack{
            VStack {
                List{
                    Text("Appointment Times")
                        .font(.system(Font.TextStyle.largeTitle))
                        .bold()
                    Section(header: Text("A specific time to receive appointments each day")) {
                        HStack{
                            
                            DateAndTimeView(value: self.$AppointmentViewModel.valueStartDate, name: "from Today", isTime: .constant(false), isDisable: true)
                                .environmentObject(AppointmentVM(numberOfServices: 7))
                                .padding(.leading,4)
                            DateAndTimeView(value: self.$AppointmentViewModel.StartvalueTime, name: "Start Time", isTime: .constant(true),isDisable: false)
                                .environmentObject(AppointmentVM(numberOfServices: 7))
                                .padding(.horizontal,-8)
                            DateAndTimeView(value: self.self.$AppointmentViewModel.EndvalueTimeDuture, name: "End Time", isTime: .constant(true),isDisable: false)
                                .environmentObject(AppointmentVM(numberOfServices: 7))
                                .padding(.trailing,4)
                        }
                        .onAppear(){
                            self.AppointmentViewModel.StartvalueTime = self.DateStore.SaveStartDate
                            self.AppointmentViewModel.EndvalueTimeDuture = self.DateStore.SaveEndDate
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
                    
                    Section(header: Text("Managing Appointments")) {
                        VStack{
                            Text("Set available time appointments")
                                .font(.system(.body))
                                .bold()
                        }
                        Toggle("Do you want to adjust the reservation days?", isOn: $learningEnabled)
                            .padding()
                        if learningEnabled {
                            StepperView(numberOfDays: self.$numberOfDaysReservation)
                        }
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
                        Toggle("Is Products", isOn: $IsProducts)
                        
                    }
                }
                .padding(.vertical)
                .navigationBarItems(trailing:
                                        Button(action: {
                    self.DateStore.StartDateAppointment = self.AppointmentViewModel.StartvalueTime.formatted(date: .omitted, time: .shortened)
                    self.DateStore.endDateAppointment =  self.AppointmentViewModel.EndvalueTimeDuture.formatted(date: .omitted, time: .shortened )
                    self.DateStore.daysReservation = self.numberOfDaysReservation
                    self.DateStore.dayOff = self.SelectedDateOff
                    self.DateStore.saveDataAppointmentToFirebase(userOwnerID: "GoD38nWf8VScmO1UnUmSSLZfXEv1", valueTime: self.AppointmentViewModel.valueTime.formatted(date: .omitted, time: .shortened), valueTimeDuture: self.AppointmentViewModel.valueTimeDuture.formatted(date: .omitted, time: .shortened))
                    self.presentationMode.wrappedValue.dismiss()
                    
                }, label: {
                    Text("Save")
                        .foregroundColor(.black)
                        .padding()
                }) )
                .onAppear {

                    self.SelectedDateOff = self.DateStore.dayOff.self
                    print(self.DateStore.StartDateAppointment.description as Any)
                    self.AppointmentViewModel.valueTime = self.DateStore.SaveStartDate
                    self.AppointmentViewModel.valueTimeDuture = self.DateStore.SaveEndDate
                }
            }
        }
    }
    
}

struct EditDateAndTimeView_Previews: PreviewProvider {
    static var previews: some View {
        EditDateAndTimeView()
            .environmentObject(AppointmentVM(numberOfServices: 7))
            .environmentObject(DateAndTimeStore())
    }
}
