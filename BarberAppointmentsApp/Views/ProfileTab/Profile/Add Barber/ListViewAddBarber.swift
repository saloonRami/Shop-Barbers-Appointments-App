//
//  ListViewAddBarber.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 23/09/2023.
//

import SwiftUI

struct ListViewAddBarber: View {

    @Binding var data : [Barber]

    var body: some View {
//            if data != nil{
                ForEach(data.indices,id:\.self) { index in
                    NavigationLink {
                        BarberInfoView(BarberInfo: self.data[index])
                    } label: {
                        VStack{
                            Text(data[index].name ?? "")
                            .font(.subheadline)
                            .foregroundStyle(Color.blue)
                            .bold()
                            .padding()
                    }
                }
            }
//        }
    }
}
struct ListViewAddBarber_Previews: PreviewProvider {
    static var previews: some View {
        ListViewAddBarber(data: .constant([Barber.init(autoID: "", isActive: true, isWorking: true, locationShop: .none, parentID: "", shopName: "", shopID: "", creationDate: "", email: "", fcm: "", isAvailable: true, isEmailVerified: true, isOwner: true, isPersistenceEnabledID: true, lastSignInDate: "", name: "", password: "", permission: "", providerID: "", refreshToken: "", tenantID: 0  , urlAutoID: "", userIDBarber: "", userIDOwner: "", userName: "", uuid: "")]))
            .environmentObject(AddBarberViewModel())
            .environmentObject(StaffManagementViewModel())
    }
}

