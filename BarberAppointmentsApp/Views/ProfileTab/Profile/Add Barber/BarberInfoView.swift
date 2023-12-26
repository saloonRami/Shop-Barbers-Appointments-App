//
//  BarberInfoView.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 27/09/2023.
//

import SwiftUI

struct BarberInfoView: View {

    var BarberInfo : Barber

    var body: some View {
//        NavigationStack{
        VStack{
            HeaderMenuBarberView(tilte: .constant(self.BarberInfo.name ?? "")){
                EmptyView()
            }
//            MenuBar(tilte: .constant(self.BarberInfo.name ?? "") ){
//                EmptyView()
//            }
            ScrollViewReader { scrollRarer in
                GeometryReader { GeometryProxy in
                    VStack{
                        HStack{
                            Text(self.BarberInfo.name ?? "")
                                .font(.headline)
                                .bold()
                        }
                        RectangleBarberInfoView(height: GeometryProxy.size.height * 1.99)
                    }.offset(y: GeometryProxy.size.height * 0.01)
                }
            }
        }
//            .background(Color.black)
//            .navigationTitle(BarberInfo.name ?? "Era")
//        }
    }
}

struct BarberInfoView_Previews: PreviewProvider {
    static var previews: some View {
        BarberInfoView(BarberInfo: Barber.init(autoID: "", isActive: true, isWorking: true, locationShop: .none, parentID: "", shopName: "", shopID: "", creationDate: "", email: "", fcm: "", isAvailable: true, isEmailVerified: true, isOwner: true, isPersistenceEnabledID: true, lastSignInDate: "", name: "", password: "", permission: "", providerID: "", refreshToken: "", tenantID: 0  , urlAutoID: "", userIDBarber: "", userIDOwner: "", userName: "", uuid: ""))
            .environmentObject(AppointmentVM(numberOfServices: 7))
    }
}

