//
//  ProfileView.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 03/09/2023.
//
import Foundation
import SwiftUI
import Combine
import CoreLocation
@available(iOS 17.0, *)
struct ProfileView: View {

    @State var cardBackgroundColor: Color = .red
    @AppStorage("IsProducts") var IsProducts: Bool = false
    @AppStorage("appearances") var appearance: Appearance = .automatic
    @AppStorage("IsReservation") var learningEnabled: Bool = false
    @AppStorage("IsLogin") var IsLogin: Bool  = false
    @State var  name: String
    @State var IsLogOut : Bool = false
    @State var valueDate: Date = Date.now
    @State var valueTime: Date = Date.today
    @State var valueTime2: Date = Date.now + 18000
    @EnvironmentObject var AddBarberVM : AddBarberViewModel
    @EnvironmentObject var LocationVM : LocationViewModel
    @EnvironmentObject var ProfileVM : ProfileSettingsViewModel
    @State private var isSelsetImage: Bool = false
    @State private var isSelsetMap: Bool = false
    @StateObject var manager : LocationManager = .init()


    var body: some View {
        NavigationStack{

            VStack{

                HStack{
                    Spacer()

                    NavigationLink {
                        PersonalInformationView(imageProfile: self.$ProfileVM.photoURL)
                    } label: {
                        PersonalProfileView(urlImage:self.$ProfileVM.photoURL , name: self.$ProfileVM.display_name, email: self.$ProfileVM.email)
                    }
                    Spacer()
                }

                Form {
                    Section(header: Text("Add barbers in your salon")) {
                        NavigationLink {
//                            AddbarberShopView()
                        } label: {
                            Text("Personal Information")
                                .font(.headline)
                                .bold()
                                .padding(.horizontal)
                        }

                        NavigationLink {
//                            AddbarberShopView()
                        } label: {
                            Text("Shop Barber Iformation")
                                .font(.headline)
                                .bold()
                                .padding(.horizontal)
                        }

                        NavigationLink {
                            AddbarberShopView(AddBarberVM: _AddBarberVM)
                                .environmentObject(AddBarberViewModel())
                        } label: {
                            Text("Add your barbers")
                                .font(.headline)
                                .bold()
                                .padding(.horizontal)
                        }
                    }

                    Section(header: Text("Appointment time management")) {
                        NavigationLink {
                            EditDateAndTimeView()
                        } label: {
                            Text("Edit Date And Time View")
                                .font(.headline)
                                .bold()
                                .padding(.horizontal)
                        }
                    }

                    Section(header: Text("Managing the services provided and service prices")) {
                        NavigationLink {
//                            EditDateAndTimeView()
                            ManagingServicesAndPricesView( servicesMenu: ServicesMenu.allCases)
                        } label: {
                            Text("Managing services and their prices")
                                .font(.headline)
                                .bold()
                                .padding(.horizontal)
                        }
                    }

                    Section(header: Text("Update your salon location")) {
                        NavigationLink {
                            addMapView(coordinate: CLLocationCoordinate2D.init(latitude: self.manager.region.center.latitude, longitude: self.manager.region.center.longitude),region:self.manager.region, IsshowsUserLocation: .constant(true))

                        } label: {
                            Text("Update your salon location")
                                .font(.headline)
                                .bold()
                                .padding(.horizontal)
                        }
                        .sheet(isPresented: self.$isSelsetMap) {

                        }
                    }
                    Section(header: Text("Necessary supplies alerts for the salon")) {

                        NavigationLink {
                        } label: {
                            Text("Add products, manage and calculate products")
                                .font(.headline)
                                .bold()
                                .padding(.horizontal)
                        }
                    }
                    Section(header: Text("Care Products")) {
                        Toggle("Is Products", isOn: $IsProducts)
                            .font(.headline)
                            .bold()
                            .padding(.horizontal)
                    }



                    Section(header: Text("Appearances")) {
                        AppearanceView( cardBackgroundColor: $cardBackgroundColor)

                    }
                        //                        EditDateAndTimeView()
                        //                            .environmentObject(AppointmentVM())
                        //                        (value: $valueDate, name: name, isTime:.constant(true),isDisable: false)
                        //                            .environmentObject(AppointmentVM())
                        //                        HStack{
                        //                            DateAndTimeView(value: $valueDate, name: "from Today", isTime: .constant(false))
                        //                            DateAndTimeView(value: $valueTime, name: "Start Time", isTime: .constant(true))
                        //                            DateAndTimeView(value: $valueTime2, name: "End Time", isTime: .constant(true))
                        //                        }
//                    }
                    Section(header: Text("Name")) {
                        Button {
                            self.ProfileVM.Logout()
                            self.IsLogOut.toggle()
                            self.IsLogin.toggle()
                        } label: {
                            Text("LogOut")
                        }
                        .fullScreenCover(isPresented: $IsLogOut) {
//                    LoginView(keyboardHandler: KeyboardFollower())
                            EmailCheckAndFetchView()
                        }
                    }
                }.listStyle(.grouped)
            }
            .task(priority: .background, {
//                self.manager.setup()
//                print( manager.region.center.latitude,manager.region.center)
                self.ProfileVM.GetUserProfile()
            })
            .navigationTitle("Profile")
        } .navigationSplitViewStyle(.prominentDetail)
    }
}
@available(iOS 17.0, *)
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(name: "Date", valueDate: .now,valueTime: .today,valueTime2: .today)
            .environmentObject(AppointmentVM(numberOfServices: 7))
            .environmentObject(ProfileSettingsViewModel())
            .environmentObject(UserBareberViewModel())
    }
}

