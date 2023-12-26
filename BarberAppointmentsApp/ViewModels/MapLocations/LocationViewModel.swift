//
//  AddLocationViewModel.swift
//  BarberShopsSaloonApp
//
//  Created by Rami Alaidy on 27/09/2023.
//

import Foundation
import Firebase

class LocationViewModel:ObservableObject{

//    @Published var BarberModel : Barber
    @Published var LocationShop : LocationShop

    init(LocationShop:LocationShop) {
//        self.BarberModel = BarberModel
        self.LocationShop = LocationShop
    }
    func addLpcationToFirebase(){
        Auth.auth().addStateDidChangeListener { auth, user in
            print(auth,user as Any)

            if (user != nil) {
                let ref = Database.database().reference()
                let uuid = user?.uid
//                guard self.BarberModel.urlAutoID != nil else {return}
                let itemsRef = ref.child("Shop_barber/Barber/\(uuid ?? "nil")")
                let post = [
                    "Location_shop" :[
                        "latitude": self.LocationShop.latitude,
                        "longitude": self.LocationShop.longitude
                    ]
                ]
                itemsRef.updateChildValues(post as [AnyHashable : Any])
            }
        }
    }
}
