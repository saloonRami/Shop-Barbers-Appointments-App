//
//  UserBareberViewModel.swift
//  BarberAppointmentsApp
//
//  Created by Rami Alaidy on 06/12/2023.
//

import Foundation
import Combine
import Firebase
import FirebaseDatabase

class UserBareberViewModel:ObservableObject{

    @Published var UserBarberModerl = UserBarberModel()

    var ref: DatabaseReference!
    var userId = Auth.auth().currentUser


    init() {
        getUserBarber()
    }

    func getUserBarber(){

        var dataJson = Data()
        self.ref = Database.database().reference()
        guard (Auth.auth().currentUser?.uid) != nil else { return  }
        ref.child("User_Barber").child(Auth.auth().currentUser!.uid).observeSingleEvent(of: .value) { snapshot in

            do{
                let dic =  snapshot.value as? NSDictionary
                let dataJson = try JSONSerialization.data (withJSONObject: dic as Any , options: [.fragmentsAllowed])
                let decodeData = JSONDecoder()
                let BarberData = try decodeData.decode(UserBarberModel.self, from: dataJson)
                self.UserBarberModerl = BarberData

            }catch{

            }
        }
    }

    func AddServiceToDataBase(userOwnerID:String,nameService:String,priceService:Int,TimeService:Int,index:Int){

        Auth.auth().addStateDidChangeListener { auth, user in
            print(auth,user as Any)
            if (user != nil) {
                let ref = Database.database().reference()
                guard  self.UserBarberModerl.childByAutoID != nil && (self.UserBarberModerl.shopID != nil) else{ return}

                let itemsRef = ref.child("Shop_barber").child(self.UserBarberModerl.shopID!).child("Barber").child(self.UserBarberModerl.childByAutoID!).child("manage_services")
                itemsRef.removeAllObservers()

                let post = [
                    "\(index)": [
                    "name_service": nameService,
                    "price_service":priceService,
                    "TimeDuration_service":TimeService
                ]
            ]
                itemsRef.updateChildValues(post as [AnyHashable : Any])
            }
        }
    }
}

